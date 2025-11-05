#!/bin/bash

# AWS ECS Deployment Script
set -e

# Configuration
AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="YOUR_ACCOUNT_ID"
ECR_REPO="auto-form-filler"
CLUSTER_NAME="auto-form-filler-cluster"
SERVICE_NAME="auto-form-filler-service"

echo "🚀 Starting AWS ECS Deployment..."

# 1. Build and push Docker image
echo "📦 Building Docker image..."
docker build -f backend/Dockerfile.prod -t $ECR_REPO:latest ./backend

echo "🔐 Logging into ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

echo "🏷️ Tagging image..."
docker tag $ECR_REPO:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO:latest

echo "⬆️ Pushing to ECR..."
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO:latest

# 2. Update task definition
echo "📝 Registering new task definition..."
aws ecs register-task-definition --cli-input-json file://aws/task-definition.json

# 3. Update service
echo "🔄 Updating ECS service..."
aws ecs update-service \
  --cluster $CLUSTER_NAME \
  --service $SERVICE_NAME \
  --task-definition auto-form-filler-backend \
  --force-new-deployment

echo "✅ Deployment completed!"
echo "🔍 Check status: aws ecs describe-services --cluster $CLUSTER_NAME --services $SERVICE_NAME"