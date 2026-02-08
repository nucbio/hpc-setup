#!/bin/bash

# Variables
PKG_NAME="pigz"
PKG_VERSION="2.8"
PKG_SRC_URL="https://zlib.net/pigz/pigz-$PKG_VERSION.tar.gz"
PKG_ARCHIVE="${PKG_NAME}_v${PKG_VERSION}.tar.gz"

# Paths
SOURCE_PATH="$INSTALL_DIR/sources/$ARCHIVE_NAME"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$TOOL_VERSION"

# Download to sources directory
wget -q "$SOURCE_URL" -O "$SOURCE_PATH"

# Create target directory and unpack
mkdir -p "$TARGET_DIR"
tar -xzf "$SOURCE_PATH" -C "$TARGET_DIR" --strip-components=1

# Compile
cd "$TARGET_DIR"
make -j$(nproc)

# Modules lua file
make_lua_module "$TOOL_NAME" "$TOOL_VERSION" "$TARGET_DIR"
