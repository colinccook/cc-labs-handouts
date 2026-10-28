#!/usr/bin/env bash
# Creates one GitHub issue per proposed-issues/*.md file.
# Each file starts with front matter:  title: ...  and  labels: a,b,c
# Idempotent: skips any issue whose exact title already exists (open or closed).
# Usage: ./create-issues.sh [--dry-run]     (needs an authenticated `gh`, or GH_TOKEN)
set -euo pipefail

DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_FLAG=()
[[ -n "${GH_REPO:-}" ]] && REPO_FLAG=(--repo "$GH_REPO")

declare -A LABEL_COLORS=(
  [content-gap]=1d76db [security]=b60205 [bug]=d73a4a [feedback]=fbca04
  [maintenance]=5319e7 [priority:high]=e11d21 [priority:medium]=f9a825 [priority:low]=c2e0c6
)

if ! $DRY_RUN; then
  for label in "${!LABEL_COLORS[@]}"; do
    gh label create "$label" --color "${LABEL_COLORS[$label]}" --force "${REPO_FLAG[@]}" >/dev/null
  done
  existing="$(gh issue list --state all --limit 1000 --json title --jq '.[].title' "${REPO_FLAG[@]}")"
else
  existing=""
fi

for file in "$DIR"/[0-9]*.md; do
  title="$(sed -n 's/^title: //p' "$file" | head -1)"
  labels="$(sed -n 's/^labels: //p' "$file" | head -1)"
  body="$(awk 'BEGIN{n=0} /^---$/ && n<2 {n++; next} n>=2' "$file")"

  if grep -Fxq -- "$title" <<<"$existing"; then
    echo "skip (exists): $title"
    continue
  fi

  if $DRY_RUN; then
    echo "would create: $title  [$labels]  ($(wc -l <<<"$body") body lines)"
  else
    gh issue create --title "$title" --label "$labels" --body "$body" "${REPO_FLAG[@]}"
  fi
done
