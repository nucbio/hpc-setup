#!/bin/bash

echo "Installing STAR aligner"

PKG_NAME="star"
PKG_VERSION="2.7.11b"

PKG_URL="https://github.com/alexdobin/STAR/releases/download/$PKG_VERSION/STAR_$PKG_VERSION.zip"

PKG_ARCHIVE="$SOURCES_DIR/$PKG_NAME-$PKG_VERSION.zip"
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION"
mkdir -p $PKG_PREFIX

wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_PREFIX" --strip-components=1

cd "$PKG_PREFIX"
make -j $(nproc)

# Modules lua file
make_lua_module $PKG_NAME $PKG_VERSION

