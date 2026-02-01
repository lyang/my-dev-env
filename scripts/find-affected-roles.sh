#!/bin/bash

set -euo pipefail

base_ref="${1:-origin/main}"

# Get changed roles from git diff
changed_roles=$(git diff --name-only "$base_ref" -- roles/ | cut -d'/' -f2 | sort -u)

if [[ -z "$changed_roles" ]]; then
  echo "[]"
  exit 0
fi

# Find roles that depend on a given role
find_dependents() {
  local role="$1"
  grep -lF -- '- role: '"$role" roles/*/meta/main.yaml 2>/dev/null | while read -r meta; do
    dirname "$meta" | xargs basename
  done
}

# Collect affected roles (changed + dependents)
affected=""
for role in $changed_roles; do
  affected="$affected $role"
  for dependent in $(find_dependents "$role"); do
    affected="$affected $dependent"
  done
done

# Output as JSON array
echo "$affected" | tr ' ' '\n' | grep -v '^$' | sort -u | jq -R . | jq -sc .
