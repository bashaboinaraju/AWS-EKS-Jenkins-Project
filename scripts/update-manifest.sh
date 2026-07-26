#!/usr/bin/env bash
set -euo pipefail

IMAGE_TAG="${1:-latest}"
ECR_REGISTRY="${2:-}"

if [ -z "$ECR_REGISTRY" ]; then
  echo "ECR registry is required" >&2
  exit 1
fi

python3 - <<'PY' "$IMAGE_TAG" "$ECR_REGISTRY"
import os, sys, pathlib
image_tag = sys.argv[1]
registry = sys.argv[2]
files = [
    pathlib.Path('backend/backend-deployment.yml'),
    pathlib.Path('frontend/main/deployment.yml'),
]
for path in files:
    if not path.exists():
        continue
    text = path.read_text()
    text = text.replace('IMAGE_TAG_PLACEHOLDER', image_tag)
    text = text.replace('ECR_REGISTRY_PLACEHOLDER', registry)
    text = text.replace('992382830933.dkr.ecr.us-east-1.amazonaws.com/shopping-site-backend:817e902f9f36a17d42641e6c38d36cafc4213026', f'{registry}/shopping-site-backend:{image_tag}')
    text = text.replace('992382830933.dkr.ecr.us-east-1.amazonaws.com/shopping-site-main:817e902f9f36a17d42641e6c38d36cafc4213026', f'{registry}/shopping-site-main:{image_tag}')
    path.write_text(text)
PY
