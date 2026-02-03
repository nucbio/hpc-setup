#!/bin/bash

# Variables
TOOL_NAME="samtools"
TOOL_VERSION="1.23"
SOURCE_URL="https://github.com/samtools/samtools/releases/download/${TOOL_VERSION}/samtools-${TOOL_VERSION}.tar.bz2"
ARCHIVE_NAME="${TOOL_NAME}_v${TOOL_VERSION}.tar.bz2"

# Paths
SOURCE_PATH="$INSTALL_DIR/sources/$ARCHIVE_NAME"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$TOOL_VERSION"
BUILD_DIR="$TARGET_DIR/build"

# Download to sources directory
wget -q "$SOURCE_URL" -O "$SOURCE_PATH"

# Create target directory and unpack
mkdir -p "$TARGET_DIR"
tar -xjf "$SOURCE_PATH" -C "$TARGET_DIR" --strip-components=1

# Configure, Build, and Install
cd "$TARGET_DIR"
mkdir -p "$BUILD_DIR"

# Running configure with your specific requirement
./configure --disable-bz2 --without-curses --prefix="$BUILD_DIR"

# Build and install into the --prefix path
make -j 8
make install

# Modules lua file
make_lua_module "$TOOL_NAME" "$TOOL_VERSION" "$BUILD_DIR/bin"

