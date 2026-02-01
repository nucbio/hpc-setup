#!/bin/bash

# Variables
TOOL_NAME="gatk"
TOOL_VERSION="4.6.2.0"
SOURCE_URL="https://github.com/broadinstitute/gatk/releases/download/${TOOL_VERSION}/gatk-${TOOL_VERSION}.zip"
ARCHIVE_NAME="${TOOL_NAME}_v${TOOL_VERSION}.zip"

# Paths
SOURCE_PATH="$INSTALL_DIR/sources/$ARCHIVE_NAME"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$TOOL_VERSION"

# Download to sources directory
wget -q "$SOURCE_URL" -O "$SOURCE_PATH"
mkdir -p "$TARGET_DIR"

# Unzip
unzip -q "$SOURCE_PATH" -d "$TARGET_DIR"

# Modules lua file
make_lua_module "$TOOL_NAME" "$TOOL_VERSION" "$TARGET_DIR/gatk-$TOOL_VERSION"
