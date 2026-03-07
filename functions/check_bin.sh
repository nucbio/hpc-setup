#!/bin/bash

# Verify installed binary: version and path
# Argument: binary name
# Usage example: check_bin "samtools"

check_bin() {
  local tool="$1"
  
  if command -v "$tool" >/dev/null 2>&1; then
    local binary_path=$(command -v "$tool")
    
    local version=$("$tool" --version 2>&1 | head -n 1 | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -n 1)
    version=${version:-"unknown version"}
    echo "[OK] $tool ($version) $binary_path"
    return 0
  else
    echo "[FAIL] $tool cannot be found in PATH"
    return 1
  fi
}

