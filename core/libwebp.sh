#!/bin/bash

export LIBWEBP_VERSION="1.6.0"

PKG_VERSION=$LIBWEBP_VERSION
PKG_NAME="libwebp"

PKG_SRC_URL="https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-$LIBWEBP_VERSION.tar.gz"
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.gz"

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

cmake -S "$PKG_SRC_DIR" -B "$PKG_BUILD_DIR" \
    -DCMAKE_INSTALL_PREFIX=$PKG_PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DWEBP_BUILD_ANIM_UTILS=ON \
    -DWEBP_BUILD_CWEBP=ON \
    -DWEBP_BUILD_DWEBP=ON \
    -DWEBP_BUILD_LIBWEBPMUX=ON \
    -DWEBP_BUILD_WEBPMUX=ON \
    -DWEBP_ENABLE_SIMD=OFF

cmake --build   "$PKG_BUILD_DIR" -j$(nproc)
cmake --install "$PKG_BUILD_DIR"

# Cleanup Build Area
rm -rf $PKG_BUILD_DIR

# Modules
make_lua_module $PKG_NAME $PKG_VERSION
