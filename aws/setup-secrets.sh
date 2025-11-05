#!/bin/bash

# AWS Secrets Manager Setup
set -e

AWS_REGION="us-east-1"

echo "🔐 Setting up AWS Secrets Manager..."

# Create secrets for API keys
echo "Creating OpenRouter API key secret..."
aws secretsmanager create-secret \
  --name "auto-form-filler/openrouter-key" \
  --description "OpenRouter API key for auto form filler" \
  --secret-string "YOUR_OPENROUTER_API_KEY" \
  --region $AWS_REGION

echo "Creating Llama Cloud API key secret..."
aws secretsmanager create-secret \
  --name "auto-form-filler/llama-key" \
  --description "Llama Cloud API key for auto form filler" \
  --secret-string "YOUR_LLAMA_CLOUD_API_KEY" \
  --region $AWS_REGION

echo "✅ Secrets created successfully!"
echo "📝 Update task-definition.json with correct ARNs"