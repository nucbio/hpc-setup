#!/bin/bash

echo "Installing Bedtools"

PKG_NAME="bedtools"
PKG_VERSION="2.31.1"

PKG_URL="https://github.com/arq5x/bedtools2/releases/download/v$PKG_VERSION/bedtools-$PKG_VERSION.tar.gz"
PKG_ARCHIVE="$SOURCES_DIR/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION"
mkdir -p $PKG_PREFIX

wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_PREFIX" --strip-components=1

cd "$PKG_PREFIX"
make -j $(nproc)

# Modules lua file
module_templater "$PKG_NAME"

