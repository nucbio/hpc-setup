#!/bin/bash

echo "Installing STAR aligner"

PKG_NAME="star"
PKG_VERSION="2.7.11b"
PKG_URL="https://github.com/alexdobin/STAR/releases/download/$PKG_VERSION/STAR_$PKG_VERSION.zip"

PKG_ARCHIVE="$SOURCES_DIR/$PKG_NAME-$PKG_VERSION.zip"
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_VERSION" # Matches /package/version
mkdir -p "$PKG_PREFIX"

# Download
wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"

# ----------------------------------- standard unzip
# Unzip Logic (Replaces Tar)
if [[ "$PKG_ARCHIVE" == *.zip ]]; then
    PKG_TMP="$PKG_PREFIX/_tmp_$$"
    mkdir -p "$PKG_TMP"
    unzip -q "$PKG_ARCHIVE" -d "$PKG_TMP"
    
    # Find the internal directory (e.g., STAR_2.7.11b)
    INTERNAL_DIR=$(find "$PKG_TMP" -mindepth 1 -maxdepth 1 -type d | head -n 1)
    
    if [[ -n "$INTERNAL_DIR" ]]; then
        shopt -s dotglob
        mv "$INTERNAL_DIR"/* "$PKG_PREFIX/"
        shopt -u dotglob
    fi
    
    rm -rf "$PKG_TMP"
else
    # Fallback for standard tarballs
    tar -xzf "$PKG_ARCHIVE" -C "$PKG_PREFIX" --strip-components=1
fi
# ------------------------------------

# Build
cd "$PKG_PREFIX" # STAR specifically builds from the /source subdir
make -j $(nproc)

# Modules lua file
# This will now place the lua file in $INSTALL_DIR/modulefiles/star/2.7.11b.lua
make_lua_module "$PKG_NAME" "$PKG_VERSION"

