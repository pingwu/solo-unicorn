#!/usr/bin/env bash
# =============================================================================
# deploy-to-s3.sh — Deploy Next.js static site to S3 + CloudFront
# =============================================================================
# Cost: ~$0.50-2/month (S3 storage + CloudFront requests)
# HTTPS: Yes (free ACM certificate via CloudFront)
# CDN: Yes (200+ CloudFront edge locations globally)
#
# Usage:
#   ./deploy-to-s3.sh <app-name> [aws-region]
#
# Examples:
#   ./deploy-to-s3.sh landing-page
#   ./deploy-to-s3.sh landing-page us-west-2
#
# First run: creates all AWS resources (~5 min)
# Subsequent runs: builds and syncs changed files only (~1 min)
#
# Prerequisites:
#   - AWS CLI v2 configured (aws configure or AWS_PROFILE set)
#   - Node.js 20+ and npm installed
#   - Appropriate IAM permissions (see PERMISSIONS section below)
#
# PERMISSIONS REQUIRED:
#   s3:CreateBucket, s3:PutBucketPolicy, s3:PutBucketPublicAccessBlock,
#   s3:PutObject, s3:DeleteObject, s3:ListBucket, s3:GetObject
#   cloudfront:CreateDistribution, cloudfront:CreateInvalidation,
#   cloudfront:GetDistribution, cloudfront:ListDistributions
#   cloudfront:CreateOriginAccessControl
# =============================================================================

set -euo pipefail

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
APP_NAME="${1:?Usage: $0 <app-name> [region]}"
REGION="${2:-${AWS_REGION:-us-east-1}}"
BUILD_DIR="out"
LOG_PREFIX="[deploy-to-s3]"

# Derive a globally unique S3 bucket name from the app name + account ID
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${PROJECT_DIR}"

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
BUCKET_NAME="${APP_NAME}-static-${ACCOUNT_ID}"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
log()  { echo "${LOG_PREFIX} $*"; }
die()  { echo "${LOG_PREFIX} ERROR: $*" >&2; exit 1; }
step() { echo ""; echo "${LOG_PREFIX} --- $* ---"; }

# ---------------------------------------------------------------------------
# Step 1: Build the static site
# ---------------------------------------------------------------------------
step "Building static site"
log "Running: npm run build"
npm run build

[[ -d "${BUILD_DIR}" ]] || die "Build directory '${BUILD_DIR}' not found after build. Check next.config.ts has output: 'export'."
log "Build complete. Output in ./${BUILD_DIR}/"

# ---------------------------------------------------------------------------
# Step 2: Create S3 bucket (idempotent)
# ---------------------------------------------------------------------------
step "Provisioning S3 bucket: ${BUCKET_NAME}"

BUCKET_EXISTS=$(aws s3api head-bucket --bucket "${BUCKET_NAME}" --region "${REGION}" 2>&1 || true)

if echo "${BUCKET_EXISTS}" | grep -q "404\|NoSuchBucket\|Not Found"; then
  log "Creating new S3 bucket..."
  if [[ "${REGION}" == "us-east-1" ]]; then
    # us-east-1 does not accept a LocationConstraint
    aws s3api create-bucket \
      --bucket "${BUCKET_NAME}" \
      --region "${REGION}" \
      --output text > /dev/null
  else
    aws s3api create-bucket \
      --bucket "${BUCKET_NAME}" \
      --region "${REGION}" \
      --create-bucket-configuration LocationConstraint="${REGION}" \
      --output text > /dev/null
  fi
  log "Bucket created: ${BUCKET_NAME}"
else
  log "Bucket already exists: ${BUCKET_NAME}"
fi

# Block all public access — CloudFront accesses via OAC, not public URLs
aws s3api put-public-access-block \
  --bucket "${BUCKET_NAME}" \
  --public-access-block-configuration \
    "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true" \
  --region "${REGION}"
log "Public access blocked on bucket (CloudFront OAC will provide access)"

# ---------------------------------------------------------------------------
# Step 3: Create or retrieve CloudFront Origin Access Control (OAC)
# ---------------------------------------------------------------------------
step "Configuring CloudFront Origin Access Control"

OAC_NAME="${APP_NAME}-oac"

# Check if OAC already exists
OAC_ID=$(aws cloudfront list-origin-access-controls \
  --query "OriginAccessControlList.Items[?Name=='${OAC_NAME}'].Id | [0]" \
  --output text 2>/dev/null || echo "None")

if [[ "${OAC_ID}" == "None" || -z "${OAC_ID}" ]]; then
  log "Creating Origin Access Control: ${OAC_NAME}"
  OAC_ID=$(aws cloudfront create-origin-access-control \
    --origin-access-control-config \
      "Name=${OAC_NAME},Description=OAC for ${APP_NAME},SigningProtocol=sigv4,SigningBehavior=always,OriginAccessControlOriginType=s3" \
    --query "OriginAccessControl.Id" \
    --output text)
  log "OAC created: ${OAC_ID}"
else
  log "Using existing OAC: ${OAC_ID}"
fi

# ---------------------------------------------------------------------------
# Step 4: Create or retrieve CloudFront distribution
# ---------------------------------------------------------------------------
step "Configuring CloudFront distribution"

DISTRIBUTION_ID=$(aws cloudfront list-distributions \
  --query "DistributionList.Items[?Comment=='${APP_NAME}-static'].Id | [0]" \
  --output text 2>/dev/null || echo "None")

if [[ "${DISTRIBUTION_ID}" == "None" || -z "${DISTRIBUTION_ID}" ]]; then
  log "Creating new CloudFront distribution..."

  S3_ORIGIN_DOMAIN="${BUCKET_NAME}.s3.${REGION}.amazonaws.com"

  # Write distribution config to a temp file to avoid shell quoting nightmares
  DIST_CONFIG_FILE=$(mktemp /tmp/cf-dist-config-XXXXXX.json)
  trap "rm -f ${DIST_CONFIG_FILE}" EXIT

  cat > "${DIST_CONFIG_FILE}" <<JSON
{
  "Comment": "${APP_NAME}-static",
  "DefaultRootObject": "index.html",
  "Origins": {
    "Quantity": 1,
    "Items": [
      {
        "Id": "${APP_NAME}-s3-origin",
        "DomainName": "${S3_ORIGIN_DOMAIN}",
        "S3OriginConfig": {
          "OriginAccessIdentity": ""
        },
        "OriginAccessControlId": "${OAC_ID}"
      }
    ]
  },
  "DefaultCacheBehavior": {
    "TargetOriginId": "${APP_NAME}-s3-origin",
    "ViewerProtocolPolicy": "redirect-to-https",
    "AllowedMethods": {
      "Quantity": 2,
      "Items": ["GET", "HEAD"]
    },
    "CachePolicyId": "658327ea-f89d-4fab-a63d-7e88639e58f6",
    "Compress": true
  },
  "CustomErrorResponses": {
    "Quantity": 1,
    "Items": [
      {
        "ErrorCode": 403,
        "ResponseCode": "404",
        "ResponsePagePath": "/404.html",
        "ErrorCachingMinTTL": 10
      }
    ]
  },
  "Enabled": true,
  "HttpVersion": "http2and3",
  "PriceClass": "PriceClass_100",
  "ViewerCertificate": {
    "CloudFrontDefaultCertificate": true,
    "MinimumProtocolVersion": "TLSv1.2_2021"
  }
}
JSON

  DISTRIBUTION_ID=$(aws cloudfront create-distribution \
    --distribution-config "file://${DIST_CONFIG_FILE}" \
    --query "Distribution.Id" \
    --output text)

  DISTRIBUTION_DOMAIN=$(aws cloudfront get-distribution \
    --id "${DISTRIBUTION_ID}" \
    --query "Distribution.DomainName" \
    --output text)

  log "Distribution created: ${DISTRIBUTION_ID}"
  log "Domain: https://${DISTRIBUTION_DOMAIN}"

  # Grant CloudFront OAC permission to read from S3
  log "Attaching S3 bucket policy for CloudFront OAC..."
  BUCKET_POLICY=$(cat <<JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowCloudFrontOAC",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudfront.amazonaws.com"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${BUCKET_NAME}/*",
      "Condition": {
        "StringEquals": {
          "AWS:SourceArn": "arn:aws:cloudfront::${ACCOUNT_ID}:distribution/${DISTRIBUTION_ID}"
        }
      }
    }
  ]
}
JSON
)
  aws s3api put-bucket-policy \
    --bucket "${BUCKET_NAME}" \
    --policy "${BUCKET_POLICY}" \
    --region "${REGION}"
  log "Bucket policy attached"

else
  DISTRIBUTION_DOMAIN=$(aws cloudfront get-distribution \
    --id "${DISTRIBUTION_ID}" \
    --query "Distribution.DomainName" \
    --output text)
  log "Using existing distribution: ${DISTRIBUTION_ID}"
  log "Domain: https://${DISTRIBUTION_DOMAIN}"
fi

# ---------------------------------------------------------------------------
# Step 5: Sync static files to S3 with correct cache headers
# ---------------------------------------------------------------------------
step "Uploading static files to S3"

# Sync HTML files — short cache (CloudFront respects these headers)
# HTML should not be cached aggressively so new deploys propagate quickly
aws s3 sync "${BUILD_DIR}/" "s3://${BUCKET_NAME}/" \
  --region "${REGION}" \
  --exclude "*" \
  --include "*.html" \
  --cache-control "public, max-age=0, must-revalidate" \
  --content-type "text/html; charset=utf-8" \
  --delete

# Sync hashed JS/CSS assets — long cache (filenames change on rebuild)
aws s3 sync "${BUILD_DIR}/_next/" "s3://${BUCKET_NAME}/_next/" \
  --region "${REGION}" \
  --cache-control "public, max-age=31536000, immutable" \
  --delete

# Sync everything else (fonts, images, favicon, etc.) — moderate cache
aws s3 sync "${BUILD_DIR}/" "s3://${BUCKET_NAME}/" \
  --region "${REGION}" \
  --exclude "*.html" \
  --exclude "_next/*" \
  --cache-control "public, max-age=86400" \
  --delete

log "Upload complete"

# ---------------------------------------------------------------------------
# Step 6: Invalidate CloudFront cache so new HTML is served immediately
# ---------------------------------------------------------------------------
step "Invalidating CloudFront cache"

INVALIDATION_ID=$(aws cloudfront create-invalidation \
  --distribution-id "${DISTRIBUTION_ID}" \
  --paths "/*.html" "/resume" "/" \
  --query "Invalidation.Id" \
  --output text)

log "Cache invalidation started: ${INVALIDATION_ID}"
log "(Propagates to all edge locations in ~1-2 minutes)"

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
echo ""
echo "============================================================"
echo "  Deployment complete!"
echo "============================================================"
echo ""
echo "  Site URL:        https://${DISTRIBUTION_DOMAIN}"
echo "  S3 Bucket:       s3://${BUCKET_NAME}"
echo "  Distribution ID: ${DISTRIBUTION_ID}"
echo "  Region:          ${REGION}"
echo ""
echo "  Estimated monthly cost: \$0.50-2.00 (low traffic)"
echo "    - S3 storage:    ~\$0.01 (< 100MB of HTML/CSS/JS)"
echo "    - CloudFront:    ~\$0.50 (first 1TB free per month)"
echo "    - Data transfer: \$0.085/GB after free tier"
echo ""
echo "  To add a custom domain (optional):"
echo "    1. Request ACM certificate in us-east-1 (required for CloudFront)"
echo "    2. Update distribution with certificate ARN and CNAME alias"
echo "    3. Add CNAME record in Route 53 pointing to ${DISTRIBUTION_DOMAIN}"
echo ""
echo "  To redeploy after changes:"
echo "    ./deploy-to-s3.sh ${APP_NAME} ${REGION}"
echo ""
echo "  To tear down all resources:"
echo "    ./teardown-s3.sh ${APP_NAME} ${REGION}"
echo "============================================================"
