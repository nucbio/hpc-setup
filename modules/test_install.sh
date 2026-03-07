#!/bin/bash

# Load modules
module purge
module load hpc-setup

# CHECK core-libraries

# List of libraries to verify
CHECK_LIBS=(
    zlib
    libpng
    libjpeg
    libtiff-4
    libwebp
    freetype2
    fontconfig
    harfbuzz
    fribidi
    cairo
    gobject-2.0
    glib-2.0
    libcurl
    openssl
    libexpat
    libxml-2.0
    pcre2
    sqlite3
    liblzma
    bzip2
    ncurses
    readline
    tcl
)

for lib in "${CHECK_LIBS[@]}"; do
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
