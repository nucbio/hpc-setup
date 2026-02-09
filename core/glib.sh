#!/bin/bash

# Dependencies: zlib, pcre2, libff
export GLIB_VERSION=2.9.6

PKG_NAME="glib"
PKG_VERSION=$GLIB_VERSION
PKG_SRC_URL="https://download.gnome.org/sources/glib/2.9/glib-$PKG_VERSION.tar.gz"
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.gz"

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

meson setup "$PKG_BUILD_DIR" "$PKG_SRC_DIR" \
    --prefix="$PKG_PREFIX" \
    --buildtype=release \
    -Dlibmount=disabled \
    -Dselinux=disabled \
    -Dtests=false

meson compile -C "$PKG_BUILD_DIR" -j $(nproc)
meson install -C "$PKG_BUILD_DIR"

# Cleanup Build Area
cd "$REPO_DIR"
rm -rf "$PKG_BUILD_DIR"

# Create Module File
make_lua_module $PKG_NAME $PKG_VERSION
