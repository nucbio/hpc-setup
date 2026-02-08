#!/bin/bash

# Configuration
PKG_NAME="gum"
export GUM_VERSION="0.17.0"
BASE_DIR="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$GUM_VERSION"
PKG_SRC_DIR="$BASE_DIR/src"
PKG_BIN_DIR="$BASE_DIR/bin"
PKG_ARCHIVE="${PKG_NAME}_${GUM_VERSION}_Linux_x86_64.tar.gz"
PKG_SRC_URL="https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/${PKG_ARCHIVE}"

# Create directory structure
mkdir -p "$PKG_SRC_DIR" "$PKG_BIN_DIR"

# Download
cd "$PKG_SRC_DIR"
wget -q "$PKG_SRC_URL" -O "$PKG_ARCHIVE"

# Decompress directly into src (stripping the top-level archive folder)
tar -xzf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

# Install the binary from src to bin and set execution permissions
install -m 0755 "$PKG_SRC_DIR/gum" "$PKG_BIN_DIR/gum"

# Move the tarball to sources for backup
mv "$PKG_ARCHIVE" "$INSTALL_DIR/sources/"

# Module
make_lua_module "$PKG_NAME" "$GUM_VERSION" "$PKG_BIN_DIR"

