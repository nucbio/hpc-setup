#!/bin/bash

PKG_NAME="bowtie2"
PKG_VERSION="2.5.4"

PKG_SRC_URL="https://github.com/BenLangmead/bowtie2/releases/download/v${PKG_VERSION}/bowtie2-${PKG_VERSION}-linux-x86_64.zip"
PKG_ARCHIVE="$SOURCES_DIR/$PKG_NAME-$PKG_VERSION.zip"

# Set PKG_SRC_DIR, PKG_PREFIX
set_pkg_dirs  $PKG_NAME $PKG_VERSION

# Download to sources directory
wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
unzip -q "$PKG_ARCHIVE" -d "$PKG_PREFIX"

# Modules lua file
make_lua_module "$PKG_NAME" "$PKG_VERSION" "$PKG_PREFIX/bowtie2-${TOOL_VERSION}-linux-x86_64"
