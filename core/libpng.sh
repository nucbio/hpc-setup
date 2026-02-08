#!/bin/bash

export LIBPNG_VERSION="1.6.50"

PKG_VERSION=$LIBPNG_VERSION
PKG_NAME="libpng"
PKG_SRC_URL="https://downloads.sourceforge.net/libpng/libpng-$LIBPNG_VERSION.tar.gz"
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.gz"

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

cd "$PKG_BUILD_DIR"
"$PKG_SRC_DIR/configure" --prefix="$PKG_PREFIX"

make -j$(nproc)
make install

# Cleanup Build Area
rm -rf $PKG_BUILD_DIR 

# Create Module File
make_lua_module "$PKG_NAME" "$PKG_VERSION"
