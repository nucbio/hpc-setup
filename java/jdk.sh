#!/bin/bash

# Variables
export JAVA_VERSION="25.0.1"
TOOL_NAME="java"
SOURCE_URL="https://download.oracle.com/java/25/archive/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/java-$JAVA_VERSION"

# 1. Download to sources directory
# Using --no-check-certificate as per your requirement
wget -q --no-check-certificate "$SOURCE_URL" \
  -O "$SOURCE_ARCHIVE/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz"

# 2. Prepare target directory and unpack
mkdir -p "$TARGET_DIR"
tar -xzf "$SOURCE_ARCHIVE/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz" \
  -C "$TARGET_DIR" --strip-components=1

# 3. Module generation
make_lua_module "java" "$JAVA_VERSION"
