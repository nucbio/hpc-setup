#!/bin/bash

# Variables
PKG_NAME="pigz"
PKG_VERSION="2.8"
PKG_SRC_URL="https://zlib.net/pigz/pigz-$PKG_VERSION.tar.gz"
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.gz"

# Set PKG_SRC_DIR, PKG_PREFIX
set_pkg_dirs  $PKG_NAME $PKG_VERSION

# Download to sources directory
wget -q "$SOURCE_URL" -O "$PKG_ARCHIVE"

# Create target directory and unpack
tar -xzf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

# Compile
cd "$PKG_SRC_DIR"
make -j $(nproc)

# Modules lua file
make_lua_module $TOOL_NAME $TOOL_VERSION "$PKG_PREFIX"
