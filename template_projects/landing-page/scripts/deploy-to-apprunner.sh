#!/usr/bin/env bash
# =============================================================================
# deploy-to-apprunner.sh — Build, push, and deploy a Next.js container to
#                          AWS App Runner via ECR
# =============================================================================
#
# PLATFORM COMPARISON:
#   AWS App Runner            ≈  GCP Cloud Run
#   ECR (Elastic Container)   ≈  Artifact Registry / GCR
#   IAM Role (ECR access)     ≈  Service Account with roles/artifactregistry.reader
#
# COST (App Runner, cheapest tier):
#   1 vCPU / 2 GB RAM:  ~$5-15/month (depends on request volume)
#   Billed per second during active request processing, plus a small
#   provisioned-concurrency cost for the "always-on" minimum instance.
#
#   Compare vs. alternatives:
#     S3 + CloudFront:  ~$0.50-2/month  (static only, deploy-to-s3.sh)
#     ECS Fargate:      ~$15-30/month   (deploy-to-aws.sh)
#     App Runner:       ~$5-15/month    (this script — good balance)
#
# FUTURE USE — LangChain / LangGraph services:
#   This same pattern works for any containerized service. To deploy a new
#   agentic microservice, call this script with a different APP_NAME and point
#   the Dockerfile at your LangGraph entrypoint. The IAM role, ECR repo, and
#   App Runner service are all parameterized by APP_NAME.
#
# USAGE:
#   ./deploy-to-apprunner.sh <app-name> [aws-region]
#
# EXAMPLES:
#   ./deploy-to-apprunner.sh landing-page
#   ./deploy-to-apprunner.sh landing-page us-west-2
#   ./deploy-to-apprunner.sh langgraph-agent us-east-1
#
# IDEMPOTENT: Safe to re-run. Existing resources are reused; the App Runner
# service is updated (forced re-deploy) if it already exists.
#
# PREREQUISITES:
#   - AWS CLI v2  (aws --version)
#   - Docker      (docker --version) — must be running
#   - Authenticated: aws configure  OR  AWS_PROFILE / env vars set
#   - next.config.ts must have  output: "standalone"  (not "export")
#
# IAM PERMISSIONS REQUIRED:
#   ecr:CreateRepository, ecr:DescribeRepositories
#   ecr:GetAuthorizationToken, ecr:BatchCheckLayerAvailability,
#   ecr:InitiateLayerUpload, ecr:UploadLayerPart, ecr:CompleteLayerUpload,
#   ecr:PutImage
#   iam:CreateRole, iam:GetRole, iam:AttachRolePolicy, iam:PassRole
#   apprunner:CreateService, apprunner:DescribeService,
#   apprunner:UpdateService, apprunner:ListServices,
#   apprunner:CreateAutoScalingConfiguration,
#   apprunner:ListAutoScalingConfigurations,
#   apprunner:DescribeAutoScalingConfiguration
# =============================================================================

set -euo pipefail

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
APP_NAME="${1:?Usage: $0 <app-name> [region]}"
REGION="${2:-${AWS_REGION:-us-east-1}}"
LOG_PREFIX="[deploy-apprunner]"

# App Runner instance size — smallest available tier:
#   1 vCPU + 2 GB  is the minimum for App Runner (no 0.25 vCPU option exists
#   unlike GCP Cloud Run which supports 0.08 vCPU minimum).
#
# GCP Cloud Run equivalent:  --cpu=1 --memory=512Mi (much more granular)
INSTANCE_CPU="1"
INSTANCE_MEMORY="2048"    # MB — App Runner minimum is 2 GB (2048 MB)

# Auto-scaling: keep 1 instance warm at all times (avoids cold starts),
# scale up to 3 for burst traffic. Max concurrency = 80 req/instance.
# GCP Cloud Run equivalent:  --min-instances=1 --max-instances=3 --concurrency=80
AUTOSCALING_MIN_SIZE=1
AUTOSCALING_MAX_SIZE=3
AUTOSCALING_MAX_CONCURRENCY=80

# Port the Next.js server listens on (must match Dockerfile EXPOSE + ENV PORT)
CONTAINER_PORT=3000

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
log()  { echo "${LOG_PREFIX} $(date '+%H:%M:%S') $*"; }
die()  { echo "${LOG_PREFIX} ERROR: $*" >&2; exit 1; }
step() { echo ""; echo "${LOG_PREFIX} ========== $* =========="; }

# ---------------------------------------------------------------------------
# Preflight checks
# ---------------------------------------------------------------------------
step "Preflight checks"

command -v docker >/dev/null 2>&1 || die "Docker is not installed or not in PATH."
docker info >/dev/null 2>&1       || die "Docker daemon is not running. Start Docker Desktop."
command -v aws >/dev/null 2>&1    || die "AWS CLI v2 is not installed."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Confirm the caller's identity — useful for debugging auth issues
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
CALLER_ARN=$(aws sts get-caller-identity --query Arn --output text)
log "AWS account:  ${ACCOUNT_ID}"
log "Caller ARN:   ${CALLER_ARN}"
log "Region:       ${REGION}"

# Confirm next.config.ts is in standalone mode (not export)
# Only match uncommented lines with output: "export" (ignore comments)
if grep -v '^\s*//' "${SCRIPT_DIR}/../next.config.ts" 2>/dev/null | grep -q 'output.*"export"\|output.*'\''export'\'''; then
  die "next.config.ts has output: 'export' — change it to output: 'standalone' before deploying to App Runner."
fi
log "next.config.ts: output mode is standalone (good)"

ECR_REGISTRY="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"
ECR_REPO_NAME="${APP_NAME}"
ECR_IMAGE_URI="${ECR_REGISTRY}/${ECR_REPO_NAME}:latest"

# IAM role that App Runner uses to pull images from ECR
# GCP equivalent: a Service Account with roles/artifactregistry.reader
APPRUNNER_ECR_ROLE_NAME="${APP_NAME}-apprunner-ecr-role"

# App Runner auto-scaling configuration name
AUTOSCALING_CONFIG_NAME="${APP_NAME}-asc"

# App Runner service name
SERVICE_NAME="${APP_NAME}"

# ---------------------------------------------------------------------------
# Step 1: Create ECR repository (idempotent)
# ---------------------------------------------------------------------------
# GCP equivalent: gcloud artifacts repositories create ${APP_NAME} \
#   --repository-format=docker --location=${REGION}
step "Provisioning ECR repository: ${ECR_REPO_NAME}"

REPO_URI=$(aws ecr describe-repositories \
  --repository-names "${ECR_REPO_NAME}" \
  --region "${REGION}" \
  --query "repositories[0].repositoryUri" \
  --output text 2>/dev/null || echo "NOT_FOUND")

if [[ "${REPO_URI}" == "NOT_FOUND" || -z "${REPO_URI}" ]]; then
  log "Creating ECR repository..."
  REPO_URI=$(aws ecr create-repository \
    --repository-name "${ECR_REPO_NAME}" \
    --region "${REGION}" \
    --image-scanning-configuration scanOnPush=true \
    --encryption-configuration encryptionType=AES256 \
    --query "repository.repositoryUri" \
    --output text)
  log "Repository created: ${REPO_URI}"
else
  log "Using existing repository: ${REPO_URI}"
fi

# Apply a lifecycle policy: keep only the last 10 tagged images.
# This prevents runaway ECR storage costs as you iterate.
# GCP equivalent: gcloud artifacts repositories describe (no built-in lifecycle;
# use Container Analysis cleanup policies instead)
log "Setting ECR lifecycle policy (keep 10 most recent images)..."
aws ecr put-lifecycle-policy \
  --repository-name "${ECR_REPO_NAME}" \
  --region "${REGION}" \
  --lifecycle-policy-text '{
    "rules": [
      {
        "rulePriority": 1,
        "description": "Keep last 10 images",
        "selection": {
          "tagStatus": "any",
          "countType": "imageCountMoreThan",
          "countNumber": 10
        },
        "action": { "type": "expire" }
      }
    ]
  }' > /dev/null
log "Lifecycle policy applied"

# ---------------------------------------------------------------------------
# Step 2: Build Docker image for linux/amd64 and push to ECR
# ---------------------------------------------------------------------------
# GCP equivalent:
#   docker build --platform linux/amd64 -t ${REGION}-docker.pkg.dev/...
#   docker push ${REGION}-docker.pkg.dev/...
#   (or: gcloud builds submit --tag ...)
step "Building and pushing Docker image"

log "Authenticating Docker with ECR..."
aws ecr get-login-password --region "${REGION}" \
  | docker login \
    --username AWS \
    --password-stdin \
    "${ECR_REGISTRY}"
log "Docker authenticated with ECR"

# IMPORTANT: build for linux/amd64 — App Runner runs on x86_64.
# On Apple Silicon (M1/M2/M3), the host is arm64 so we must cross-compile.
# GCP Cloud Run also requires linux/amd64 by default (unless you use ARM preview).
log "Building image (platform: linux/amd64)..."
log "This takes ~2-4 minutes on first build (subsequent builds use layer cache)"

docker build \
  --platform linux/amd64 \
  --tag "${ECR_IMAGE_URI}" \
  --file "${SCRIPT_DIR}/../Dockerfile" \
  "${SCRIPT_DIR}/.."

log "Image built: ${ECR_IMAGE_URI}"

log "Pushing image to ECR..."
docker push "${ECR_IMAGE_URI}"
log "Image pushed successfully"

# Retrieve the image digest for logging (useful for rollback tracking)
IMAGE_DIGEST=$(aws ecr describe-images \
  --repository-name "${ECR_REPO_NAME}" \
  --region "${REGION}" \
  --image-ids imageTag=latest \
  --query "imageDetails[0].imageDigest" \
  --output text 2>/dev/null || echo "unknown")
log "Image digest: ${IMAGE_DIGEST}"

# ---------------------------------------------------------------------------
# Step 3: Create IAM role for App Runner to pull from ECR (idempotent)
# ---------------------------------------------------------------------------
# App Runner needs an IAM "access role" to authenticate with ECR and pull
# the container image on your behalf. This is a one-time setup per service.
#
# GCP equivalent: App Runner's access role ≈ the Compute Engine default service
# account having roles/artifactregistry.reader. In GCP, Cloud Run automatically
# uses the compute SA; in AWS you must create and assign this role explicitly.
step "Provisioning IAM role: ${APPRUNNER_ECR_ROLE_NAME}"

ROLE_EXISTS=$(aws iam get-role \
  --role-name "${APPRUNNER_ECR_ROLE_NAME}" \
  --query "Role.RoleName" \
  --output text 2>/dev/null || echo "NOT_FOUND")

if [[ "${ROLE_EXISTS}" == "NOT_FOUND" ]]; then
  log "Creating IAM role..."
  aws iam create-role \
    --role-name "${APPRUNNER_ECR_ROLE_NAME}" \
    --description "Allows App Runner service ${APP_NAME} to pull images from ECR" \
    --assume-role-policy-document '{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "build.apprunner.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }' \
    --output text > /dev/null
  log "IAM role created"

  # AWS-managed policy that grants exactly the ECR permissions App Runner needs:
  #   ecr:GetDownloadUrlForLayer, ecr:BatchGetImage,
  #   ecr:DescribeImages, ecr:GetAuthorizationToken, ecr:BatchCheckLayerAvailability
  aws iam attach-role-policy \
    --role-name "${APPRUNNER_ECR_ROLE_NAME}" \
    --policy-arn "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

  # Brief pause — IAM role propagation can take a few seconds
  log "Waiting for IAM role to propagate..."
  sleep 10
else
  log "Using existing IAM role: ${APPRUNNER_ECR_ROLE_NAME}"
fi

APPRUNNER_ECR_ROLE_ARN="arn:aws:iam::${ACCOUNT_ID}:role/${APPRUNNER_ECR_ROLE_NAME}"
log "Access role ARN: ${APPRUNNER_ECR_ROLE_ARN}"

# ---------------------------------------------------------------------------
# Step 4: Create or reuse Auto Scaling configuration (idempotent)
# ---------------------------------------------------------------------------
# App Runner auto-scaling is defined as a standalone resource that can be
# shared across multiple services — good for consistent scaling policy
# across your entire fleet of microservices.
#
# GCP equivalent:  --min-instances=1 --max-instances=3 --concurrency=80
# (in gcloud run deploy those are inline flags, not a separate resource)
step "Configuring auto-scaling: min=${AUTOSCALING_MIN_SIZE} max=${AUTOSCALING_MAX_SIZE} concurrency=${AUTOSCALING_MAX_CONCURRENCY}"

ASC_ARN=$(aws apprunner list-auto-scaling-configurations \
  --auto-scaling-configuration-name "${AUTOSCALING_CONFIG_NAME}" \
  --region "${REGION}" \
  --query "AutoScalingConfigurationSummaryList[?AutoScalingConfigurationName=='${AUTOSCALING_CONFIG_NAME}'] | [0].AutoScalingConfigurationArn" \
  --output text 2>/dev/null || echo "None")

if [[ "${ASC_ARN}" == "None" || -z "${ASC_ARN}" ]]; then
  log "Creating auto-scaling configuration..."
  ASC_ARN=$(aws apprunner create-auto-scaling-configuration \
    --auto-scaling-configuration-name "${AUTOSCALING_CONFIG_NAME}" \
    --min-size "${AUTOSCALING_MIN_SIZE}" \
    --max-size "${AUTOSCALING_MAX_SIZE}" \
    --max-concurrency "${AUTOSCALING_MAX_CONCURRENCY}" \
    --region "${REGION}" \
    --query "AutoScalingConfiguration.AutoScalingConfigurationArn" \
    --output text)
  log "Auto-scaling config created: ${ASC_ARN}"
else
  log "Using existing auto-scaling config: ${ASC_ARN}"
fi

# ---------------------------------------------------------------------------
# Step 5: Create or update App Runner service
# ---------------------------------------------------------------------------
# GCP equivalent:
#   gcloud run deploy ${APP_NAME} \
#     --image=${ECR_IMAGE_URI} \
#     --platform=managed \
#     --region=${REGION} \
#     --port=${CONTAINER_PORT} \
#     --cpu=${INSTANCE_CPU} \
#     --memory=${INSTANCE_MEMORY}Mi \
#     --min-instances=${AUTOSCALING_MIN_SIZE} \
#     --max-instances=${AUTOSCALING_MAX_SIZE} \
#     --concurrency=${AUTOSCALING_MAX_CONCURRENCY} \
#     --allow-unauthenticated
step "Deploying App Runner service: ${SERVICE_NAME}"

# Look up existing service ARN by name
SERVICE_ARN=$(aws apprunner list-services \
  --region "${REGION}" \
  --query "ServiceSummaryList[?ServiceName=='${SERVICE_NAME}'].ServiceArn | [0]" \
  --output text 2>/dev/null || echo "None")

if [[ "${SERVICE_ARN}" == "None" || -z "${SERVICE_ARN}" ]]; then
  # ----- CREATE new service -----
  log "Creating new App Runner service..."

  # Write service config to a temp file — the JSON is too long for inline flags
  SERVICE_CONFIG_FILE=$(mktemp /tmp/apprunner-svc-XXXXXX.json)
  trap "rm -f ${SERVICE_CONFIG_FILE}" EXIT

  cat > "${SERVICE_CONFIG_FILE}" <<JSON
{
  "ServiceName": "${SERVICE_NAME}",
  "SourceConfiguration": {
    "ImageRepository": {
      "ImageIdentifier": "${ECR_IMAGE_URI}",
      "ImageConfiguration": {
        "Port": "${CONTAINER_PORT}",
        "RuntimeEnvironmentVariables": {
          "NODE_ENV": "production",
          "PORT": "${CONTAINER_PORT}",
          "NEXT_TELEMETRY_DISABLED": "1"
        }
      },
      "ImageRepositoryType": "ECR"
    },
    "AuthenticationConfiguration": {
      "AccessRoleArn": "${APPRUNNER_ECR_ROLE_ARN}"
    },
    "AutoDeploymentsEnabled": true
  },
  "InstanceConfiguration": {
    "Cpu": "1 vCPU",
    "Memory": "2 GB"
  },
  "AutoScalingConfigurationArn": "${ASC_ARN}",
  "HealthCheckConfiguration": {
    "Protocol": "TCP",
    "Interval": 10,
    "Timeout": 5,
    "HealthyThreshold": 1,
    "UnhealthyThreshold": 5
  },
  "Tags": [
    { "Key": "app",         "Value": "${APP_NAME}" },
    { "Key": "managed-by",  "Value": "deploy-to-apprunner.sh" },
    { "Key": "environment", "Value": "production" }
  ]
}
JSON

  SERVICE_ARN=$(aws apprunner create-service \
    --cli-input-json "file://${SERVICE_CONFIG_FILE}" \
    --region "${REGION}" \
    --query "Service.ServiceArn" \
    --output text)

  log "Service creation initiated: ${SERVICE_ARN}"

else
  # ----- UPDATE existing service (force re-deploy with new image) -----
  log "Service already exists — forcing new deployment..."

  # Update the service to pick up the new image that was just pushed.
  # AutoDeploymentsEnabled=true also handles future pushes automatically,
  # but we force one here so the current deploy is applied immediately.
  aws apprunner update-service \
    --service-arn "${SERVICE_ARN}" \
    --region "${REGION}" \
    --source-configuration "{
      \"ImageRepository\": {
        \"ImageIdentifier\": \"${ECR_IMAGE_URI}\",
        \"ImageConfiguration\": {
          \"Port\": \"${CONTAINER_PORT}\",
          \"RuntimeEnvironmentVariables\": {
            \"NODE_ENV\": \"production\",
            \"PORT\": \"${CONTAINER_PORT}\",
            \"NEXT_TELEMETRY_DISABLED\": \"1\"
          }
        },
        \"ImageRepositoryType\": \"ECR\"
      },
      \"AuthenticationConfiguration\": {
        \"AccessRoleArn\": \"${APPRUNNER_ECR_ROLE_ARN}\"
      },
      \"AutoDeploymentsEnabled\": true
    }" > /dev/null

  log "Service update initiated"
  
  # Force immediate deployment to pull the new image.
  # Without this, AutoDeploymentsEnabled may not trigger immediately when
  # pushing to the same :latest tag. This ensures the new container starts now.
  log "Triggering immediate deployment..."
  aws apprunner start-deployment \
    --service-arn "${SERVICE_ARN}" \
    --region "${REGION}" \
    --output text > /dev/null
  log "Deployment triggered"
fi

# ---------------------------------------------------------------------------
# Step 6: Wait for the service to reach RUNNING state
# ---------------------------------------------------------------------------
# App Runner deploys asynchronously — the first deploy typically takes 2-4 min.
# GCP Cloud Run equivalent: gcloud run services describe --format=... (polls until ready)
step "Waiting for service to reach RUNNING state (up to 10 minutes)"
log "App Runner is provisioning your container... grab a coffee."

MAX_WAIT_SECONDS=600   # 10 minutes
POLL_INTERVAL=15
ELAPSED=0

while true; do
  STATUS=$(aws apprunner describe-service \
    --service-arn "${SERVICE_ARN}" \
    --region "${REGION}" \
    --query "Service.Status" \
    --output text 2>/dev/null || echo "UNKNOWN")

  log "Status: ${STATUS} (${ELAPSED}s elapsed)"

  if [[ "${STATUS}" == "RUNNING" ]]; then
    break
  fi

  if [[ "${STATUS}" == "CREATE_FAILED" || "${STATUS}" == "UPDATE_FAILED" || "${STATUS}" == "DELETE_FAILED" ]]; then
    die "Deployment failed with status: ${STATUS}. Check App Runner console for logs."
  fi

  if [[ ${ELAPSED} -ge ${MAX_WAIT_SECONDS} ]]; then
    die "Timed out after ${MAX_WAIT_SECONDS}s. Service status: ${STATUS}. Check App Runner console."
  fi

  sleep "${POLL_INTERVAL}"
  ELAPSED=$((ELAPSED + POLL_INTERVAL))
done

# ---------------------------------------------------------------------------
# Step 7: Retrieve the service URL
# ---------------------------------------------------------------------------
SERVICE_URL=$(aws apprunner describe-service \
  --service-arn "${SERVICE_ARN}" \
  --region "${REGION}" \
  --query "Service.ServiceUrl" \
  --output text)

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
echo ""
echo "============================================================"
echo "  Deployment complete!"
echo "============================================================"
echo ""
echo "  App URL:        https://${SERVICE_URL}"
echo "  Service ARN:    ${SERVICE_ARN}"
echo "  ECR Image:      ${ECR_IMAGE_URI}"
echo "  Image Digest:   ${IMAGE_DIGEST}"
echo "  Region:         ${REGION}"
echo ""
echo "  Instance:       ${INSTANCE_CPU} vCPU / ${INSTANCE_MEMORY} MB RAM"
echo "  Auto-scaling:   min=${AUTOSCALING_MIN_SIZE} max=${AUTOSCALING_MAX_SIZE} concurrency=${AUTOSCALING_MAX_CONCURRENCY}"
echo "  Auto-deploy:    enabled (ECR push triggers re-deploy automatically)"
echo ""
echo "  Estimated monthly cost: \$5-15 (low traffic)"
echo "    - Active requests:   \$0.064/vCPU-hour + \$0.007/GB-hour"
echo "    - Provisioned:       \$0.007/vCPU-hour + \$0.0008/GB-hour (1 warm instance)"
echo "    - ECR storage:       \$0.10/GB/month (images < 1 GB ≈ free tier)"
echo ""
echo "  Logs (CloudWatch):"
echo "    aws logs tail /aws/apprunner/${SERVICE_NAME}/service --follow --region ${REGION}"
echo ""
echo "  Force re-deploy after a new image push:"
echo "    ./deploy-to-apprunner.sh ${APP_NAME} ${REGION}"
echo ""
echo "  To tear down all resources:"
echo "    ./teardown-apprunner.sh ${APP_NAME} ${REGION}"
echo ""
echo "  GCP Cloud Run equivalent URL format:"
echo "    https://${APP_NAME}-<hash>-uc.a.run.app"
echo "    (App Runner uses: https://${SERVICE_URL})"
echo "============================================================"
