#!/bin/bash

# Download release for linux amd64 from https://github.com/jgm/pandoc/releases

# Variables
TOOL_NAME="pandoc"
PANDOC_VERSION="3.8.3"
SOURCE_URL="https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux-amd64.tar.gz"
ARCHIVE_NAME="${TOOL_NAME}_v${PANDOC_VERSION}.tar.gz"

# Paths
SOURCE_PATH="$INSTALL_DIR/sources/$ARCHIVE_NAME"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$PANDOC_VERSION"

# Download to sources directory
wget -q "$SOURCE_URL" -O "$SOURCE_PATH"
mkdir -p "$TARGET_DIR"
tar -xzf "$SOURCE_PATH" -C "$TARGET_DIR" --strip-components=1

# Modules lua file
make_lua_module "$TOOL_NAME" "$PANDOC_VERSION" "$TARGET_DIR"
