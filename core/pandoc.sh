#!/bin/bash

PKG_NAME="pandoc"
PKG_VERSION="3.8.3"
export PANDOC_VERSION=$PKG_VERSION
PKG_URL="https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux-amd64.tar.gz"
PKG_ARCHIVE="$SOURCES_DIR/$PKG_NAME-$PKG_VERSION.tar.xz"

# Set PKG_SRC_DIR, PKG_PREFIX
set_pkg_dirs  $PKG_NAME $PKG_VERSION

# Download to sources directory
wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_PREFIX" --strip-components=1

# Modules lua file
make_lua_module "$PKG_NAME" "$PANDOC_VERSION" "$PKG_PREFIX"
