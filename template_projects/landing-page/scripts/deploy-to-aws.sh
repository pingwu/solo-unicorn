#!/bin/bash
# =============================================================================
# NOTICE: This script deploys to ECS Fargate (~$15-30/month).
#
# The RECOMMENDED deployment is S3 + CloudFront (~$0.50-2/month).
# Use deploy-to-s3.sh instead for this static landing page.
#
# If you switch back to this ECS deployment, you MUST first restore
# next.config.ts to use:  output: "standalone"
# (Currently set to:      output: "export"  for static site generation)
# =============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REGION="us-east-1"
APP_NAME="landing-page"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

echo "🚀 Deploying $APP_NAME to AWS ECS Fargate..."

# 1. Create ECR repository
echo "📦 Creating ECR repository..."
aws ecr describe-repositories --repository-names $APP_NAME --region $REGION 2>/dev/null || \
  aws ecr create-repository --repository-name $APP_NAME --region $REGION

# 2. Build and push Docker image
echo "🐳 Building and pushing Docker image..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
docker build -t $APP_NAME -f "${SCRIPT_DIR}/../Dockerfile" "${SCRIPT_DIR}/.."
docker tag $APP_NAME:latest $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$APP_NAME:latest
docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$APP_NAME:latest

# 3. Create ECS cluster
echo "🏗️  Creating ECS cluster..."
aws ecs describe-clusters --clusters $APP_NAME --region $REGION 2>/dev/null || \
  aws ecs create-cluster --cluster-name $APP_NAME --region $REGION

# 4. Create CloudWatch log group
echo "📊 Creating CloudWatch log group..."
aws logs describe-log-groups --log-group-name-prefix /ecs/$APP_NAME --region $REGION 2>/dev/null || \
  aws logs create-log-group --log-group-name /ecs/$APP_NAME --region $REGION

# 5. Create IAM role for ECS task execution
echo "🔐 Creating IAM roles..."
ROLE_NAME="${APP_NAME}-task-execution-role"
aws iam get-role --role-name $ROLE_NAME 2>/dev/null || \
  aws iam create-role --role-name $ROLE_NAME \
    --assume-role-policy-document '{
      "Version": "2012-10-17",
      "Statement": [{
        "Effect": "Allow",
        "Principal": {"Service": "ecs-tasks.amazonaws.com"},
        "Action": "sts:AssumeRole"
      }]
    }'

aws iam attach-role-policy --role-name $ROLE_NAME \
  --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy 2>/dev/null || true

# 6. Register task definition
echo "📝 Registering task definition..."
cat > task-def.json <<EOF
{
  "family": "$APP_NAME",
  "networkMode": "awsvpc",
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "256",
  "memory": "512",
  "executionRoleArn": "arn:aws:iam::$ACCOUNT_ID:role/$ROLE_NAME",
  "containerDefinitions": [{
    "name": "$APP_NAME",
    "image": "$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$APP_NAME:latest",
    "portMappings": [{
      "containerPort": 3000,
      "protocol": "tcp"
    }],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/$APP_NAME",
        "awslogs-region": "$REGION",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }]
}
EOF

aws ecs register-task-definition --cli-input-json file://task-def.json --region $REGION

# 7. Get default VPC and subnets
echo "🌐 Getting VPC configuration..."
VPC_ID=$(aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text --region $REGION)
SUBNET_IDS=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" --query "Subnets[*].SubnetId" --output text --region $REGION | tr '\t' ',')

# 8. Create security group
echo "🔒 Creating security group..."
SG_ID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=${APP_NAME}-sg" "Name=vpc-id,Values=$VPC_ID" --query "SecurityGroups[0].GroupId" --output text --region $REGION 2>/dev/null)

if [ "$SG_ID" == "None" ] || [ -z "$SG_ID" ]; then
  SG_ID=$(aws ec2 create-security-group \
    --group-name "${APP_NAME}-sg" \
    --description "Security group for $APP_NAME" \
    --vpc-id $VPC_ID \
    --region $REGION \
    --query 'GroupId' --output text)
  
  aws ec2 authorize-security-group-ingress \
    --group-id $SG_ID \
    --protocol tcp \
    --port 3000 \
    --cidr 0.0.0.0/0 \
    --region $REGION
fi

# 9. Run ECS service
echo "🚢 Creating ECS service..."
aws ecs create-service \
  --cluster $APP_NAME \
  --service-name $APP_NAME \
  --task-definition $APP_NAME \
  --desired-count 1 \
  --launch-type FARGATE \
  --network-configuration "awsvpcConfiguration={subnets=[$SUBNET_IDS],securityGroups=[$SG_ID],assignPublicIp=ENABLED}" \
  --region $REGION 2>/dev/null || \
  aws ecs update-service \
    --cluster $APP_NAME \
    --service $APP_NAME \
    --force-new-deployment \
    --region $REGION

# 10. Wait for task to start and get public IP
echo "⏳ Waiting for task to start..."
sleep 30

TASK_ARN=$(aws ecs list-tasks --cluster $APP_NAME --service-name $APP_NAME --region $REGION --query 'taskArns[0]' --output text)
ENI_ID=$(aws ecs describe-tasks --cluster $APP_NAME --tasks $TASK_ARN --region $REGION --query 'tasks[0].attachments[0].details[?name==`networkInterfaceId`].value' --output text)
PUBLIC_IP=$(aws ec2 describe-network-interfaces --network-interface-ids $ENI_ID --region $REGION --query 'NetworkInterfaces[0].Association.PublicIp' --output text)

echo ""
echo "✅ Deployment complete!"
echo "🌍 Public URL: http://$PUBLIC_IP:3000"
echo ""
echo "📊 View logs: aws logs tail /ecs/$APP_NAME --follow --region $REGION"
echo "🛑 To stop: aws ecs update-service --cluster $APP_NAME --service $APP_NAME --desired-count 0 --region $REGION"
