#!/bin/bash

# https://github.com/libjpeg-turbo/libjpeg-turbo/releases
PKG_NAME="libjpeg"
PKG_VERSION="3.1.2"
export LIBJPEG_VERSION=$PKG_VERSION
PKG_SRC_URL="https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/$LIBJPEG_VERSION/libjpeg-turbo-$LIBJPEG_VERSION.tar.gz"
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.gz"

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

cmake -S "$PKG_SRC_DIR" -B "$PKG_BUILD_DIR" \
    -DCMAKE_INSTALL_PREFIX=$PKG_PREFIX

cmake --build   $PKG_BUILD_DIR -j$(nproc) 
cmake --install $PKG_BUILD_DIR

# Cleanup Build Area
cd "$REPO_DIR"
rm -rf "$PKG_BUILD_DIR"

# Modules
make_lua_module $PKG_NAME $PKG_VERSION
