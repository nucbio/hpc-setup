#!/usr/bin/env bash
# Bump VERSION, commit + push hpc-setup, render the docs site, then commit + push hpc-setup-docs.
#
# Usage: deploy/git_upload.sh "commit message"
#
# Expects hpc-setup-docs next to this repo (override with DOCS_DIR).
# The docs are rendered into hpc-setup-docs/docs/, which GitHub Pages serves from main.
set -euo pipefail

MSG="${1:?usage: $0 \"commit message\"}"
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOCS="${DOCS_DIR:-$REPO/../hpc-setup-docs}"

command -v quarto >/dev/null || { echo "quarto not found (https://quarto.org/docs/get-started/)" >&2; exit 1; }
[[ -f "$DOCS/_quarto.yml" ]] || { echo "docs repo not found at $DOCS (set DOCS_DIR)" >&2; exit 1; }

commit_push() {
    local dir="$1"
    git -C "$dir" add -A
    if git -C "$dir" diff --cached --quiet; then
        echo "== $(basename "$dir"): nothing to commit"
    else
        git -C "$dir" commit -m "$MSG"
    fi
    git -C "$dir" push
}

# Bump the last number in VERSION (1.0.0 -> 1.0.1) on every run.
VERSION_FILE="$REPO/VERSION"
OLD="$(tr -d '[:space:]' < "$VERSION_FILE")"
[[ "$OLD" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)$ ]] || { echo "bad VERSION: '$OLD' (expected X.Y.Z)" >&2; exit 1; }
NEW="${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.$((BASH_REMATCH[3] + 1))"
echo "$NEW" > "$VERSION_FILE"
echo "== version $OLD -> $NEW"

echo "== hpc-setup"
commit_push "$REPO"

echo "== rendering docs"
HPC_SETUP_DIR="$REPO" quarto render "$DOCS"
touch "$DOCS/docs/.nojekyll"

echo "== hpc-setup-docs"
commit_push "$DOCS"

echo "== done: https://nucbio.github.io/hpc-setup-docs/"
