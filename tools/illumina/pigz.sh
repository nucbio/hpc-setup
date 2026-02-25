#!/bin/bash

echo "Installing Pigz"

PKG_NAME="pigz"
PKG_VERSION="2.8"
PKG_URL="https://zlib.net/pigz/pigz-$PKG_VERSION.tar.gz"
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_RREFIX=$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION
mkdir -p $PKG_PREFIX

wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_PREFIX" --strip-components=1

cd "$PKG_PREFIX"
make -j $(nproc)

# Modules lua file
make_lua_module $TOOL_NAME $TOOL_VERSION
