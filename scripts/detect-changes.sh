#!/usr/bin/env bash
set -euo pipefail

changed_files=$(git diff --name-only HEAD~1 HEAD 2>/dev/null || true)
if [ -z "$changed_files" ]; then
  changed_files=$(git ls-files)
fi

printf '%s
' "$changed_files"
