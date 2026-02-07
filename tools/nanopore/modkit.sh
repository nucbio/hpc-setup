#!/bin/bash

echo "Install modkit"
# Variables
export MODKIT_VERSION="0.5.0"
TOOL_NAME="modkit"
SOURCE_URL="https://github.com/nanoporetech/modkit/releases/download/v0.6.0/modkit_v0.6.0_u16_x86_64.tar.gz"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$MODKIT_VERSION"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"

mkdir -p "$SOURCE_ARCHIVE"
cd "$SOURCE_ARCHIVE"
wget "$SOURCE_URL" -O "${TOOL_NAME}-${MODKIT_VERSION}.tar.gz"
mkdir -p "$TARGET_DIR/bin"
tar -xzf "${TOOL_NAME}-${MODKIT_VERSION}.tar.gz" -C "$TARGET_DIR/bin" --strip-components=1

# Module
make_lua_module "modkit" "$MODKIT_VERSION" "$TARGET_DIR/bin"
