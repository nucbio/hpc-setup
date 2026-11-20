#!/bin/bash

# Check that pkgs.json is the only place package versions are set.
# Runs without building anything. Run it after every version bump.
#   bash modules/check_versions.sh          # static checks
#   bash modules/check_versions.sh --urls   # also check that every pkg_url downloads
# Needs jq (and curl for --urls). Exit status 1 if a check fails.

REPO_DIR="${REPO_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
PKGS_JSON="$REPO_DIR/pkgs.json"
cd "$REPO_DIR" || exit 1

SCRIPTS=(core/*.sh tools/*/*.sh python/*.sh R/*.sh rust/*.sh java/*.sh lua/*.sh)
FAIL=0
fail() { echo "[FAIL] $*"; FAIL=1; }

# 1. Every json package is installed by some script, read from the json
while IFS=$'\t' read -r name type; do
  [[ "$type" == "meta" ]] && continue
  if ! grep -qE "(pkg_version|pkg_url) \"?$name\"?( |\)|$)|-n \"$name\"|(PKG|TOOL)_NAME=\"$name\"" "${SCRIPTS[@]}"; then
    fail "$name: no install script reads it from pkgs.json"
  fi
done < <(jq -r 'to_entries[] | "\(.key)\t\(.value.inst_type)"' "$PKGS_JSON")

# 2. Every module_templater / pkg_install name has a json entry
while read -r name; do
  [[ "$name" == '$PKG_NAME' || "$name" == '$TOOL_NAME' ]] && continue
  [[ "$(jq -r --arg p "$name" 'has($p)' "$PKGS_JSON")" == "true" ]] || fail "$name: used in a script but missing in pkgs.json"
done < <(grep -hoE '(module_templater|-n) "[^"]+"' "${SCRIPTS[@]}" | cut -d'"' -f2 | sort -u)

# 3. No hardcoded versions in scripts. Allowed: helpers that have no json entry
#    (luarocks, Lmod, nanopolish's bundled HDF5/Eigen/VBZ).
ALLOWED='LUAROCKS_VERSION|LUASOCKET_VERSION|LUAPOSIX_VERSION|LUAFILESYSTEM_VERSION|LMOD_VERSION|HDF5_VERSION|EIGEN_VERSION|VBZ_VERSION'
HITS=$(grep -nE '^\s*(export\s+)?[A-Z0-9_]*VERSION=("[0-9]|[0-9])|-v "?[0-9]' "${SCRIPTS[@]}" \
       | grep -vE "($ALLOWED)=")
if [[ -n "$HITS" ]]; then
  echo "$HITS" | sed 's/^/[FAIL] hardcoded version: /'
  FAIL=1
fi

# 4. pkg_url contains pkg_version (catches a label that does not match the download)
#    Skipped: cargo/venv (no URL or git URL), rust (rustup), sqlite3 (3.54.1 -> 3540100).
while IFS=$'\t' read -r name type ver url; do
  case "$type" in meta|cargo|venv) continue ;; esac
  case "$name" in rust) continue ;; esac
  if [[ "$name" == sqlite3 ]]; then
    IFS=. read -r a b c <<< "$ver"
    ver=$(printf '%d%02d%02d00' "$a" "$b" "${c:-0}")
  fi
  [[ "$url" == *"$ver"* ]] || fail "$name: pkg_url does not contain version $ver ($url)"
done < <(jq -r 'to_entries[] | "\(.key)\t\(.value.inst_type)\t\(.value.pkg_version)\t\(.value.pkg_url)"' "$PKGS_JSON")

# 5. Optional: every download URL answers
if [[ "$1" == "--urls" ]]; then
  while IFS=$'\t' read -r name type url; do
    case "$type" in meta|venv) continue ;; esac
    code=$(curl -s -o /dev/null -L -r 0-0 --max-time 30 -w '%{http_code}' "$url")
    [[ "$code" == 200 || "$code" == 206 ]] && echo "[OK] $name $code" || fail "$name: $url -> HTTP $code"
  done < <(jq -r 'to_entries[] | "\(.key)\t\(.value.inst_type)\t\(.value.pkg_url)"' "$PKGS_JSON")
  # venv packages: version exists on PyPI
  while read -r name ver; do
    code=$(curl -s -o /dev/null --max-time 30 -w '%{http_code}' "https://pypi.org/pypi/$name/$ver/json")
    [[ "$code" == 200 ]] && echo "[OK] $name $ver (PyPI)" || fail "$name $ver not on PyPI (HTTP $code)"
  done < <(jq -r 'to_entries[] | select(.value.inst_type=="venv") | "\(.key) \(.value.pkg_version)"' "$PKGS_JSON")
fi

[[ $FAIL -eq 0 ]] && echo "check_versions: all checks passed" || echo "check_versions: FAILED"
exit $FAIL
