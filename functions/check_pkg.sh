#!/bin/bash

# Quck verification of installed package: get version and path
# Check package via pkgconf and path.
# Argument: package name
# Usage example: check_pkg "samtools"

check_pkg() {
  local PKG_NAME="$1"

  # pkgconf name from pkgs.json (e.g. glib -> glib-2.0); falls back to PKG_NAME
  local PC_NAME
  PC_NAME=$(jq -r --arg p "$PKG_NAME" '.[$p].pkgconf // empty' "$REPO_DIR/pkgs.json" 2>/dev/null)
  PC_NAME="${PC_NAME:-$PKG_NAME}"

  # binary name when it differs from the package name
  local BIN_NAME="$PKG_NAME"
  case "$PKG_NAME" in
    rust)    BIN_NAME="rustc" ;;
    ripgrep) BIN_NAME="rg" ;;
  esac

  # pkgconf (--modversion, not --exists: --exists also fails on missing
  # Requires.private deps such as system libidn2/libzstd)
  if pkgconf --modversion "$PC_NAME"  >/dev/null 2>&1; then
    local PKG_PATH=$(pkgconf --variable=libdir "$PC_NAME")
    local PKG_VER=$(pkgconf --modversion "$PC_NAME")
    echo "[OK] $PKG_NAME ($PKG_VER) $PKG_PATH"
    return 0
  fi

  # binary in PATH
 if command -v "$BIN_NAME" >/dev/null 2>&1; then
   local PKG_PATH=$(command -v "$BIN_NAME")
   local PKG_VER=$(timeout 2s "$BIN_NAME" --version 2>&1 | \
     head -n 1 | \
     grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | \
     head -n 1)
   echo "[OK] $PKG_NAME ($PKG_VER) $PKG_PATH"
   return 0
  fi

  echo "[FAIL] $PKG_NAME not found."
  return 1
}
