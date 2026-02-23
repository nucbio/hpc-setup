#!/bin/bash

# Load modules

# Test installation in the end

for lib in zlib libxml-2.0 openssl liblzma; do
    if pkgconf --exists "$lib"; then
        LIB_PATH=$(pkgconf --variable=libdir "$lib")
        LIB_VER=$(pkgconf --modversion "$lib")
        
        echo "[OK] $lib ($LIB_VER) $LIB_PATH"
    else
        echo "[FAIL] $lib cannot be found by pkgconf"
    fi
done

echo "--- Verifying Binary Modules ---"

# List your binaries here
BINARIES="samtools bowtie2 python3 git curl"

for tool in $BINARIES; do
    if command -v "$tool" >/dev/null 2>&1; then
        # Get the full path to the executable
        BINARY_PATH=$(command -v "$tool")
        VERSION=$("$tool" --version 2>&1 | head -n 1 | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -n 1)
        echo "[OK] $tool ($VERSION) found at: $BINARY_PATH"
    else
        echo "[FAIL] $tool cannot be found in PATH"
    fi
done
