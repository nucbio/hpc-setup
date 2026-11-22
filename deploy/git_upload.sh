#!/usr/bin/env bash
# Bump VERSION, commit + push hpc-setup, render the docs site, then commit + push hpc-setup-docs.
#
# Usage: deploy/git_upload.sh [-m|-M] "commit message"
#
#   (default)  bump patch: 1.0.14 -> 1.0.15
#   -m         release: bump minor (1.0.14 -> 1.1.0) and push git tag 1.1.0
#   -M         release: bump major (1.0.14 -> 2.0.0) and push git tag 2.0.0
#
# Expects hpc-setup-docs next to this repo (override with DOCS_DIR).
# The docs are rendered into hpc-setup-docs/docs/, which GitHub Pages serves from main.
set -euo pipefail

BUMP=patch
case "${1:-}" in
    -m) BUMP=minor; shift ;;
    -M) BUMP=major; shift ;;
esac

MSG="${1:?usage: $0 [-m|-M] \"commit message\"}"
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

# Bump VERSION on every run: patch by default, minor/major (+ release tag) with -m/-M.
VERSION_FILE="$REPO/VERSION"
OLD="$(tr -d '[:space:]' < "$VERSION_FILE")"
[[ "$OLD" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)$ ]] || { echo "bad VERSION: '$OLD' (expected X.Y.Z)" >&2; exit 1; }
MAJ="${BASH_REMATCH[1]}" MIN="${BASH_REMATCH[2]}" PAT="${BASH_REMATCH[3]}"
case "$BUMP" in
    major) NEW="$((MAJ + 1)).0.0" ;;
    minor) NEW="$MAJ.$((MIN + 1)).0" ;;
    *)     NEW="$MAJ.$MIN.$((PAT + 1))" ;;
esac

# Check before touching anything, so an existing tag aborts cleanly.
if [[ "$BUMP" != patch ]] && git -C "$REPO" rev-parse -q --verify "refs/tags/$NEW" >/dev/null; then
    echo "tag $NEW already exists" >&2; exit 1
fi

echo "$NEW" > "$VERSION_FILE"
echo "== version $OLD -> $NEW"

echo "== hpc-setup"
commit_push "$REPO"

if [[ "$BUMP" != patch ]]; then
    git -C "$REPO" tag -a "$NEW" -m "Release version $NEW"
    git -C "$REPO" push origin "$NEW"
    echo "== tagged release $NEW"
fi

echo "== rendering docs"
HPC_SETUP_DIR="$REPO" quarto render "$DOCS"
touch "$DOCS/docs/.nojekyll"

echo "== hpc-setup-docs"
commit_push "$DOCS"

echo "== done: https://nucbio.github.io/hpc-setup-docs/"
