#!/usr/bin/env bash
# =============================================================================
# teardown-s3.sh — Remove all S3 + CloudFront resources for the static site
# =============================================================================
# WARNING: This permanently deletes the S3 bucket and its contents,
# disables and deletes the CloudFront distribution, and removes the OAC.
# This action cannot be undone.
#
# Usage:
#   ./teardown-s3.sh <app-name> [aws-region]
#
# Example:
#   ./teardown-s3.sh landing-page
# =============================================================================

set -euo pipefail

APP_NAME="${1:?Usage: $0 <app-name> [region]}"
REGION="${2:-${AWS_REGION:-us-east-1}}"
LOG_PREFIX="[teardown-s3]"

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
BUCKET_NAME="${APP_NAME}-static-${ACCOUNT_ID}"

log()  { echo "${LOG_PREFIX} $*"; }
step() { echo ""; echo "${LOG_PREFIX} --- $* ---"; }

echo ""
echo "WARNING: This will permanently delete:"
echo "  - S3 bucket:           ${BUCKET_NAME}"
echo "  - CloudFront dist:     (comment: ${APP_NAME}-static)"
echo "  - Origin Access Ctrl:  ${APP_NAME}-oac"
echo ""
read -rp "Type 'yes' to confirm: " CONFIRM
[[ "${CONFIRM}" == "yes" ]] || { echo "Aborted."; exit 0; }

# ---------------------------------------------------------------------------
# Disable and delete CloudFront distribution
# ---------------------------------------------------------------------------
step "Disabling CloudFront distribution"

DISTRIBUTION_ID=$(aws cloudfront list-distributions \
  --query "DistributionList.Items[?Comment=='${APP_NAME}-static'].Id | [0]" \
  --output text 2>/dev/null || echo "None")

if [[ "${DISTRIBUTION_ID}" != "None" && -n "${DISTRIBUTION_ID}" ]]; then
  # Get current ETag (required for updates)
  ETAG=$(aws cloudfront get-distribution \
    --id "${DISTRIBUTION_ID}" \
    --query "ETag" \
    --output text)

  STATUS=$(aws cloudfront get-distribution \
    --id "${DISTRIBUTION_ID}" \
    --query "Distribution.Status" \
    --output text)

  if [[ "${STATUS}" != "Deployed" ]]; then
    log "Distribution is in status '${STATUS}', waiting for Deployed state..."
    aws cloudfront wait distribution-deployed --id "${DISTRIBUTION_ID}"
  fi

  # Get and modify config to disable
  DIST_CONFIG_FILE=$(mktemp /tmp/cf-disable-XXXXXX.json)
  trap "rm -f ${DIST_CONFIG_FILE}" EXIT

  aws cloudfront get-distribution-config \
    --id "${DISTRIBUTION_ID}" \
    --query "DistributionConfig" \
    --output json > "${DIST_CONFIG_FILE}"

  # Set Enabled: false using Python (avoids jq dependency)
  python3 -c "
import json, sys
with open('${DIST_CONFIG_FILE}', 'r') as f:
    cfg = json.load(f)
cfg['Enabled'] = False
with open('${DIST_CONFIG_FILE}', 'w') as f:
    json.dump(cfg, f)
"

  ETAG=$(aws cloudfront update-distribution \
    --id "${DISTRIBUTION_ID}" \
    --if-match "${ETAG}" \
    --distribution-config "file://${DIST_CONFIG_FILE}" \
    --query "ETag" \
    --output text)

  log "Distribution disabled. Waiting for propagation (~5 min)..."
  aws cloudfront wait distribution-deployed --id "${DISTRIBUTION_ID}"

  ETAG=$(aws cloudfront get-distribution \
    --id "${DISTRIBUTION_ID}" \
    --query "ETag" \
    --output text)

  aws cloudfront delete-distribution \
    --id "${DISTRIBUTION_ID}" \
    --if-match "${ETAG}"
  log "Distribution deleted: ${DISTRIBUTION_ID}"
else
  log "No distribution found for: ${APP_NAME}-static"
fi

# ---------------------------------------------------------------------------
# Delete Origin Access Control
# ---------------------------------------------------------------------------
step "Deleting Origin Access Control"

OAC_ID=$(aws cloudfront list-origin-access-controls \
  --query "OriginAccessControlList.Items[?Name=='${APP_NAME}-oac'].Id | [0]" \
  --output text 2>/dev/null || echo "None")

if [[ "${OAC_ID}" != "None" && -n "${OAC_ID}" ]]; then
  OAC_ETAG=$(aws cloudfront get-origin-access-control \
    --id "${OAC_ID}" \
    --query "ETag" \
    --output text)
  aws cloudfront delete-origin-access-control \
    --id "${OAC_ID}" \
    --if-match "${OAC_ETAG}"
  log "OAC deleted: ${OAC_ID}"
else
  log "No OAC found: ${APP_NAME}-oac"
fi

# ---------------------------------------------------------------------------
# Empty and delete S3 bucket
# ---------------------------------------------------------------------------
step "Deleting S3 bucket: ${BUCKET_NAME}"

BUCKET_EXISTS=$(aws s3api head-bucket --bucket "${BUCKET_NAME}" --region "${REGION}" 2>&1 || echo "not_found")
if ! echo "${BUCKET_EXISTS}" | grep -q "not_found\|404\|NoSuchBucket"; then
  log "Emptying bucket..."
  aws s3 rm "s3://${BUCKET_NAME}/" --recursive --region "${REGION}"
  aws s3api delete-bucket --bucket "${BUCKET_NAME}" --region "${REGION}"
  log "Bucket deleted: ${BUCKET_NAME}"
else
  log "Bucket not found: ${BUCKET_NAME}"
fi

echo ""
echo "============================================================"
echo "  Teardown complete. All resources removed."
echo "  Monthly charges for ${APP_NAME}: \$0.00"
echo "============================================================"
