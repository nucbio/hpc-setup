#!/bin/bash

# pkgs.json is the single source of truth for package versions and URLs.
# Install scripts read them with these helpers instead of hardcoding them.
# Usage: PKG_VERSION=$(pkg_version "zlib")
#        PKG_URL=$(pkg_url "zlib")
# Assign with a plain VAR=$(...) (not `export VAR=$(...)` or `local VAR=$(...)`),
# so that a missing entry stops the install under `set -e`.

pkg_field() {
  local name="$1" field="$2" value
  value=$(jq -r --arg p "$name" --arg f "$field" '.[$p][$f] // empty' "$REPO_DIR/pkgs.json") || return 1
  if [[ -z "$value" ]]; then
    echo "ERROR: pkgs.json has no '$field' for package '$name'" >&2
    return 1
  fi
  printf '%s\n' "$value"
}

pkg_version() { pkg_field "$1" pkg_version; }
pkg_url()     { pkg_field "$1" pkg_url; }
