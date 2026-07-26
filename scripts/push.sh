#!/usr/bin/env bash
set -euo pipefail

IMAGE_TAG="${1:-latest}"
ECR_REGISTRY="${2:-}"

if [ -z "$ECR_REGISTRY" ]; then
  echo "ECR registry is required" >&2
  exit 1
fi

for image in "$ECR_REGISTRY/shopping-site-backend:$IMAGE_TAG" "$ECR_REGISTRY/shopping-site-main:$IMAGE_TAG"; do
  docker push "$image"
done
