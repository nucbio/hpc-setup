#!/bin/bash

export JAVA_VERSION="25.0.1"

PKG_VERSION=$JAVA_VERSION
PKG_NAME="java"
PKG_SRC_URL="https://download.oracle.com/java/25/archive/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz"
PKG_ARCHIVE="$SOURCES_DIR/$PKG_NAME-$PKG_VERSION.tar.xz"

# Set PKG_SRC_DIR, PKG_PREFIX
set_pkg_dirs  $PKG_NAME $PKG_VERSION

# Download to sources directory
wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_PREFIX" --strip-components=1

# Modules lua file
make_lua_module $PKG_NAME $PKG_VERSION
