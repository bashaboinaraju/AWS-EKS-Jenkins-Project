#!/usr/bin/env bash
set -euo pipefail

TOKEN="${1:-}"
if [ -z "$TOKEN" ]; then
  echo "GitHub token is required" >&2
  exit 1
fi

git config user.name "jenkins-bot"
git config user.email "jenkins-bot@example.com"

if ! git diff --quiet; then
  git add backend/backend-deployment.yml frontend/main/deployment.yml
  git commit -m "chore: update image tags"
  git remote set-url origin "https://x-access-token:${TOKEN}@github.com/bashaboinaraju/AWS-EKS-Jenkins-Project.git"
  git push origin HEAD:main
else
  echo "No manifest changes to commit"
fi
