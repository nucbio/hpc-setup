#!/bin/bash

# Variables
TOOL_NAME="fastqc"
TOOL_VERSION="0.12.1"
SOURCE_URL="https://github.com/s-andrews/FastQC/archive/refs/tags/v$VERSION.zip"
ARCHIVE_NAME="${TOOL_NAME}_v${VERSION}.zip"

# Paths
SOURCE_PATH="$INSTALL_DIR/sources/$ARCHIVE_NAME"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$VERSION"

# Download to sources directory
wget -q "$SOURCE_URL" -O "$SOURCE_PATH"
mkdir -p "$TARGET_DIR"
unzip -q "$SOURCE_PATH" -d "$TARGET_DIR"

# Modules lua file
make_lua_module $TOOL_NAME $TOOL_VERSION "$TARGET_DIR/FastQC-$TOOL_VERSION"
