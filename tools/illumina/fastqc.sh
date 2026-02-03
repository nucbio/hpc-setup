#!/bin/bash

# Variables
TOOL_NAME="fastqc"
TOOL_VERSION="0.12.1"
SOURCE_URL="https://www.bioinformatics.babraham.ac.uk/projects/fastqc/${TOOL_NAME}_v${FASTQ_VERSION}.zip"
ARCHIVE_NAME="${TOOL_NAME}_v${TOOL_VERSION}.zip"

# Paths
SOURCE_PATH="$INSTALL_DIR/sources/$ARCHIVE_NAME"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$TOOL_VERSION"

# Download to sources directory
wget -q "$SOURCE_URL" -O "$SOURCE_PATH"
mkdir -p "$TARGET_DIR"
unzip -q "$SOURCE_PATH" -d "$TARGET_DIR"

# Modules lua file
make_lua_module $TOOL_NAME $TOOL_VERSION "$TARGET_DIR/FastQC-$TOOL_VERSION"
