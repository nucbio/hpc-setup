#!/bin/bash

# Variables
TOOL_NAME="gatk"
TOOL_VERSION="4.6.2.0"
SOURCE_URL="https://github.com/broadinstitute/gatk/releases/download/${PKG_VERSION}/gatk-${PKG_VERSION}.zip"
PKG_ARCHIVE="$SOURCES/${TOOL_NAME}-${TOOL_VERSION}.zip"

# Paths
PKG_PREFIX="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$TOOL_VERSION"

wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
unzip -q "$PKG_ARCHIVE" -d "$PKG_PREFIX"

# Modules lua file
make_lua_module "$PKG_NAME" "$PKG_VERSION" "$PKG_PREFIX/gatk-$PKG_VERSION"
