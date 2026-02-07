#!/bin/bash

# Configuration
TOOL="gum"
export GUM_VERSION="0.17.0"
BASE_DIR="$INSTALL_DIR/$TOOL/$TOOL-$GUM_VERSION"
SRC_DIR="$BASE_DIR/src"
BIN_DIR="$BASE_DIR/bin"
TARBALL="${TOOL}_${GUM_VERSION}_Linux_x86_64.tar.gz"
URL="https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/${TARBALL}"

# Create directory structure
mkdir -p "$SRC_DIR" "$BIN_DIR" "$INSTALL_DIR/sources"

# Download
cd "$SRC_DIR"
wget -q "$URL" -O "$TARBALL"

# Decompress directly into src (stripping the top-level archive folder)
tar -xzf "$TARBALL" -C "$SRC_DIR" --strip-components=1

# Install the binary from src to bin and set execution permissions
install -m 0755 "$SRC_DIR" "$BIN_DIR"

# Move the tarball to sources for backup
mv "$TARBALL" "$INSTALL_DIR/sources/"

# Module
make_lua_module "$TOOL" "$GUM_VERSION" "$BIN_DIR"

