#!/bin/bash

# Verify installed library: version and path
# Argument: library name
# Usage example: check_lib zlib

check_lib() {
  local lib="$1"
  
  if pkgconf --exists "$lib"; then
    local LIB_PATH=$(pkgconf --variable=libdir "$lib")
    local LIB_VER=$(pkgconf --modversion "$lib")
    
    echo "[OK] $lib ($LIB_VER) $LIB_PATH"
    return 0
  else
    echo "[FAIL] $lib cannot be found by pkgconf"
    return 1
  fi
}


