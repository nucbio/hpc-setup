#!/bin/bash

# Download release for linux amd64 from https://github.com/jgm/pandoc/releases

# Variables
PKG_NAME="pandoc"
export PANDOC_VERSION="3.8.3"
PKG_SRC_URL="https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux-amd64.tar.gz"
ARCHIVE_NAME="${PKG_NAME}_v${PANDOC_VERSION}.tar.gz"

# Paths
SOURCE_PATH="$INSTALL_DIR/sources/$ARCHIVE_NAME"
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PANDOC_VERSION"

# Download to sources directory
wget -q "$PKG_SRC_URL" -O "$SOURCE_PATH"
mkdir -p "$PKG_PREFIX"
tar -xzf "$SOURCE_PATH" -C "$PKG_PREFIX" --strip-components=1

# Modules lua file
make_lua_module "$PKG_NAME" "$PANDOC_VERSION" "$PKG_PREFIX"
