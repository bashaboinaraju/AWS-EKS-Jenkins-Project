#!/usr/bin/env bash
set -euo pipefail

IMAGE_TAG="${1:-latest}"
ECR_REGISTRY="${2:-}"

if [ -z "$ECR_REGISTRY" ]; then
  echo "ECR registry is required" >&2
  exit 1
fi

for service in backend frontend/main; do
  case "$service" in
    backend)
      docker build -t "$ECR_REGISTRY/shopping-site-backend:$IMAGE_TAG" backend/
      ;;
    frontend/main)
      docker build -t "$ECR_REGISTRY/shopping-site-main:$IMAGE_TAG" frontend/main/
      ;;
  esac
done
