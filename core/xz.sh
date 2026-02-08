#!/bin/bash

PKG_NAME="xz"
PKG_VERSION="5.8.2"
export XZ_VERSION=$PKG_VERSION
PKG_SRC_URL="https://github.com/tukaani-project/xz/releases/download/v${XZ_VERSION}/xz-${XZ_VERSION}.tar.xz"
PKG_ARCHIVE="$SOURCES_DIR/$PKG_NAME-$PKG_VERSION.tar.xz"

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
tar -xJf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

cd "$PKG_BUILD_DIR"
"$PKG_SRC_DIR/configure" --prefix="$PKG_PREFIX"

make -j$(nproc)
make install

# Cleanup Build Area
rm -rf $PKG_BUILD_DIR

# Create Module File
make_lua_module $PKG_NAME $PKG_VERSION
