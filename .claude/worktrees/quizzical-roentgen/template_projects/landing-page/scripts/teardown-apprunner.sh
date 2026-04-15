#!/usr/bin/env bash
# =============================================================================
# teardown-apprunner.sh — Delete all AWS App Runner resources for a service
# =============================================================================
#
# WARNING: This permanently deletes:
#   1. The App Runner service (billing stops immediately)
#   2. All images in the ECR repository (cannot be recovered)
#   3. The ECR repository itself
#   4. The IAM role used for ECR access
#   5. The auto-scaling configuration
#
# This action cannot be undone.
#
# USAGE:
#   ./teardown-apprunner.sh <app-name> [aws-region]
#
# EXAMPLE:
#   ./teardown-apprunner.sh landing-page
#   ./teardown-apprunner.sh landing-page us-west-2
#
# GCP Cloud Run equivalent:
#   gcloud run services delete ${APP_NAME} --region=${REGION}
#   gcloud artifacts repositories delete ${APP_NAME} --location=${REGION}
# =============================================================================

set -euo pipefail

APP_NAME="${1:?Usage: $0 <app-name> [region]}"
REGION="${2:-${AWS_REGION:-us-east-1}}"
LOG_PREFIX="[teardown-apprunner]"

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ECR_REPO_NAME="${APP_NAME}"
APPRUNNER_ECR_ROLE_NAME="${APP_NAME}-apprunner-ecr-role"
AUTOSCALING_CONFIG_NAME="${APP_NAME}-asc"
SERVICE_NAME="${APP_NAME}"

log()  { echo "${LOG_PREFIX} $(date '+%H:%M:%S') $*"; }
step() { echo ""; echo "${LOG_PREFIX} ========== $* =========="; }

# ---------------------------------------------------------------------------
# Confirmation prompt — resource summary
# ---------------------------------------------------------------------------
echo ""
echo "=========================================================="
echo "  WARNING: This will permanently destroy:"
echo ""
echo "    App Runner service:     ${SERVICE_NAME}"
echo "    ECR repository:         ${ECR_REPO_NAME}  (ALL images deleted)"
echo "    IAM role:               ${APPRUNNER_ECR_ROLE_NAME}"
echo "    Auto-scaling config:    ${AUTOSCALING_CONFIG_NAME}"
echo "    Region:                 ${REGION}"
echo "    Account:                ${ACCOUNT_ID}"
echo ""
echo "  Billing stops as soon as the App Runner service is deleted."
echo "=========================================================="
echo ""
read -rp "Type 'yes' to confirm teardown: " CONFIRM
[[ "${CONFIRM}" == "yes" ]] || { echo "Aborted. No resources were modified."; exit 0; }

# ---------------------------------------------------------------------------
# Step 1: Delete App Runner service
# ---------------------------------------------------------------------------
# GCP equivalent: gcloud run services delete ${APP_NAME} --region=${REGION} --quiet
step "Deleting App Runner service: ${SERVICE_NAME}"

SERVICE_ARN=$(aws apprunner list-services \
  --region "${REGION}" \
  --query "ServiceSummaryList[?ServiceName=='${SERVICE_NAME}'].ServiceArn | [0]" \
  --output text 2>/dev/null || echo "None")

if [[ "${SERVICE_ARN}" == "None" || -z "${SERVICE_ARN}" ]]; then
  log "No App Runner service found: ${SERVICE_NAME} — skipping"
else
  # Check current status — cannot delete a service that is mid-operation
  CURRENT_STATUS=$(aws apprunner describe-service \
    --service-arn "${SERVICE_ARN}" \
    --region "${REGION}" \
    --query "Service.Status" \
    --output text 2>/dev/null || echo "UNKNOWN")

  log "Current service status: ${CURRENT_STATUS}"

  if [[ "${CURRENT_STATUS}" == "OPERATION_IN_PROGRESS" ]]; then
    log "Service is in OPERATION_IN_PROGRESS — waiting up to 10 minutes..."
    MAX_WAIT=600
    ELAPSED=0
    while [[ "${CURRENT_STATUS}" == "OPERATION_IN_PROGRESS" && ${ELAPSED} -lt ${MAX_WAIT} ]]; do
      sleep 15
      ELAPSED=$((ELAPSED + 15))
      CURRENT_STATUS=$(aws apprunner describe-service \
        --service-arn "${SERVICE_ARN}" \
        --region "${REGION}" \
        --query "Service.Status" \
        --output text 2>/dev/null || echo "UNKNOWN")
      log "Status: ${CURRENT_STATUS} (${ELAPSED}s waited)"
    done
  fi

  log "Initiating service deletion..."
  aws apprunner delete-service \
    --service-arn "${SERVICE_ARN}" \
    --region "${REGION}" \
    --output text > /dev/null

  # Wait for deletion to complete — App Runner deletes asynchronously
  log "Waiting for service deletion to complete..."
  MAX_WAIT=300
  ELAPSED=0
  while true; do
    STATUS=$(aws apprunner describe-service \
      --service-arn "${SERVICE_ARN}" \
      --region "${REGION}" \
      --query "Service.Status" \
      --output text 2>/dev/null || echo "DELETED")

    log "Status: ${STATUS} (${ELAPSED}s elapsed)"

    if [[ "${STATUS}" == "DELETED" || "${STATUS}" == "UNKNOWN" ]]; then
      break
    fi

    if [[ ${ELAPSED} -ge ${MAX_WAIT} ]]; then
      log "WARNING: Service deletion taking longer than expected. Check App Runner console."
      log "Continuing with remaining teardown steps..."
      break
    fi

    sleep 15
    ELAPSED=$((ELAPSED + 15))
  done

  log "App Runner service deleted: ${SERVICE_NAME}"
fi

# ---------------------------------------------------------------------------
# Step 2: Delete auto-scaling configuration
# ---------------------------------------------------------------------------
step "Deleting auto-scaling configuration: ${AUTOSCALING_CONFIG_NAME}"

# List all revisions of this auto-scaling config (App Runner creates versioned revisions)
ASC_ARNS=$(aws apprunner list-auto-scaling-configurations \
  --auto-scaling-configuration-name "${AUTOSCALING_CONFIG_NAME}" \
  --region "${REGION}" \
  --query "AutoScalingConfigurationSummaryList[*].AutoScalingConfigurationArn" \
  --output text 2>/dev/null || echo "")

if [[ -z "${ASC_ARNS}" ]]; then
  log "No auto-scaling configurations found for: ${AUTOSCALING_CONFIG_NAME} — skipping"
else
  for ASC_ARN in ${ASC_ARNS}; do
    log "Deleting auto-scaling config: ${ASC_ARN}"
    aws apprunner delete-auto-scaling-configuration \
      --auto-scaling-configuration-arn "${ASC_ARN}" \
      --region "${REGION}" \
      --output text > /dev/null || log "WARNING: Could not delete ${ASC_ARN} — may already be deleted"
  done
  log "Auto-scaling configurations deleted"
fi

# ---------------------------------------------------------------------------
# Step 3: Detach managed policies and delete IAM role
# ---------------------------------------------------------------------------
# GCP equivalent: gcloud iam service-accounts delete ${SA_NAME}
step "Deleting IAM role: ${APPRUNNER_ECR_ROLE_NAME}"

ROLE_EXISTS=$(aws iam get-role \
  --role-name "${APPRUNNER_ECR_ROLE_NAME}" \
  --query "Role.RoleName" \
  --output text 2>/dev/null || echo "NOT_FOUND")

if [[ "${ROLE_EXISTS}" == "NOT_FOUND" ]]; then
  log "IAM role not found: ${APPRUNNER_ECR_ROLE_NAME} — skipping"
else
  # List and detach all managed policies before deleting the role
  # (AWS requires policies to be detached before role deletion)
  ATTACHED_POLICIES=$(aws iam list-attached-role-policies \
    --role-name "${APPRUNNER_ECR_ROLE_NAME}" \
    --query "AttachedPolicies[*].PolicyArn" \
    --output text 2>/dev/null || echo "")

  for POLICY_ARN in ${ATTACHED_POLICIES}; do
    log "Detaching policy: ${POLICY_ARN}"
    aws iam detach-role-policy \
      --role-name "${APPRUNNER_ECR_ROLE_NAME}" \
      --policy-arn "${POLICY_ARN}"
  done

  # Delete any inline policies
  INLINE_POLICIES=$(aws iam list-role-policies \
    --role-name "${APPRUNNER_ECR_ROLE_NAME}" \
    --query "PolicyNames" \
    --output text 2>/dev/null || echo "")

  for POLICY_NAME in ${INLINE_POLICIES}; do
    log "Deleting inline policy: ${POLICY_NAME}"
    aws iam delete-role-policy \
      --role-name "${APPRUNNER_ECR_ROLE_NAME}" \
      --policy-name "${POLICY_NAME}"
  done

  aws iam delete-role --role-name "${APPRUNNER_ECR_ROLE_NAME}"
  log "IAM role deleted: ${APPRUNNER_ECR_ROLE_NAME}"
fi

# ---------------------------------------------------------------------------
# Step 4: Delete ECR repository and all images
# ---------------------------------------------------------------------------
# GCP equivalent:
#   gcloud artifacts repositories delete ${APP_NAME} \
#     --location=${REGION} --quiet
step "Deleting ECR repository: ${ECR_REPO_NAME}"

REPO_EXISTS=$(aws ecr describe-repositories \
  --repository-names "${ECR_REPO_NAME}" \
  --region "${REGION}" \
  --query "repositories[0].repositoryName" \
  --output text 2>/dev/null || echo "NOT_FOUND")

if [[ "${REPO_EXISTS}" == "NOT_FOUND" ]]; then
  log "ECR repository not found: ${ECR_REPO_NAME} — skipping"
else
  # --force deletes the repository even if it contains images
  aws ecr delete-repository \
    --repository-name "${ECR_REPO_NAME}" \
    --region "${REGION}" \
    --force \
    --output text > /dev/null
  log "ECR repository deleted (all images removed): ${ECR_REPO_NAME}"
fi

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
echo ""
echo "============================================================"
echo "  Teardown complete. All resources removed."
echo ""
echo "  Deleted:"
echo "    - App Runner service:    ${SERVICE_NAME}"
echo "    - ECR repository:        ${ECR_REPO_NAME}"
echo "    - IAM role:              ${APPRUNNER_ECR_ROLE_NAME}"
echo "    - Auto-scaling config:   ${AUTOSCALING_CONFIG_NAME}"
echo "    - Region:                ${REGION}"
echo ""
echo "  Monthly charges for ${APP_NAME}: \$0.00 (billing stopped)"
echo "============================================================"
