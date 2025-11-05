# AWS ECS Deployment Guide

## 🔐 Security Features

- **Secrets Manager**: API keys stored securely
- **Non-root container**: Runs as unprivileged user
- **IAM roles**: Minimal required permissions
- **VPC networking**: Private subnets with ALB
- **CloudWatch logs**: Centralized logging

## 🚀 Deployment Steps

### 1. Prerequisites
```bash
# Install AWS CLI
aws configure

# Create ECR repository
aws ecr create-repository --repository-name auto-form-filler --region us-east-1
```

### 2. Setup Secrets
```bash
# Update your API keys in setup-secrets.sh
chmod +x aws/setup-secrets.sh
./aws/setup-secrets.sh
```

### 3. Create IAM Roles
```bash
# Create execution role
aws iam create-role --role-name ecsTaskExecutionRole --assume-role-policy-document file://aws/trust-policy.json
aws iam attach-role-policy --role-name ecsTaskExecutionRole --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy
aws iam put-role-policy --role-name ecsTaskExecutionRole --policy-name SecretsManagerAccess --policy-document file://aws/iam-policies.json

# Create task role
aws iam create-role --role-name ecsTaskRole --assume-role-policy-document file://aws/trust-policy.json
```

### 4. Update Configuration
```bash
# Update these files with your AWS account details:
# - aws/task-definition.json
# - aws/deploy.sh
```

### 5. Deploy
```bash
chmod +x aws/deploy.sh
./aws/deploy.sh
```

## 🛡️ Security Best Practices

1. **API Keys**: Never hardcode in containers
2. **Network**: Use private subnets + ALB
3. **Monitoring**: Enable CloudWatch + CloudTrail
4. **Updates**: Regular security patches
5. **Access**: Least privilege IAM policies

## 📊 Monitoring

```bash
# View logs
aws logs tail /ecs/auto-form-filler --follow

# Check service status
aws ecs describe-services --cluster auto-form-filler-cluster --services auto-form-filler-service
```