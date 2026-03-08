#!/bin/bash

# Quck verification of installed package: get version and path
# Check package via pkgconf and path.
# Argument: package name
# Usage example: check_pkg "samtools"

check_pkg() {
  local PKG_NAME="$1"

  # pkgconf
  if pkgconf --exists "$PKG_NAME"  >/dev/null 2>&1; then
    local PKG_PATH=$(pkgconf --variable=libdir "$PKG_NAME")
    local PKG_VER=$(pkgconf --modversion "$PKG_NAME")
    echo "[OK] $PKG_NAME ($PKG_VER) $PKG_PATH"
    return 0
  fi

  # binary in PATH
 if command -v "$PKG_NAME" >/dev/null 2>&1; then
   local PKG_PATH=$(command -v "$PKG_NAME")
   local PKG_VER=$(timeout 2s "$PKG_NAME" --version 2>&1 | \
     head -n 1 | \
     grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | \
     head -n 1)
   echo "[OK] $PKG_NAME ($PKG_VER) $PKG_PATH"
   return 0
  fi

  echo "[FAIL] $PKG_NAME not found."
  return 1
}
