#!/usr/bin/env bash
set -euo pipefail

if ! command -v aws >/dev/null 2>&1; then
  echo "aws CLI is required" >&2
  exit 1
fi

aws ecr describe-repositories --region "$AWS_REGION" >/dev/null 2>&1 || {
  echo "ECR repository not found or AWS credentials are invalid" >&2
  exit 1
}

aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$ECR_REGISTRY"
