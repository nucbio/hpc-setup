#!/bin/bash

# Variables
TOOL_NAME="bowtie2"
TOOL_VERSION="2.5.4"
# Using the pre-compiled linux binary link
SOURCE_URL="https://github.com/BenLangmead/bowtie2/releases/download/v${TOOL_VERSION}/bowtie2-${TOOL_VERSION}-linux-x86_64.zip"
ARCHIVE_NAME="${TOOL_NAME}_v${TOOL_VERSION}.zip"

# Paths
SOURCE_PATH="$INSTALL_DIR/sources/$ARCHIVE_NAME"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$TOOL_VERSION"

# Download and Unpack
wget -q "$SOURCE_URL" -O "$SOURCE_PATH"
mkdir -p "$TARGET_DIR"
unzip -q "$SOURCE_PATH" -d "$TARGET_DIR"

# Modules lua file
make_lua_module "$TOOL_NAME" "$TOOL_VERSION" "$TARGET_DIR/bowtie2-${TOOL_VERSION}-linux-x86_64"
