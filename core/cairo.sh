#!/bin/bash

export CAIRO_VERSION="1.18.4"

PKG_VERSION=$CAIRO_VERSION
PKG_NAME="cairo"
PKG_SRC_URL="https://cairographics.org/releases/cairo-${CAIRO_VERSION}.tar.xz"
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.xz"

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
tar -xJf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

meson setup "$PKG_BUILD_DIR" "$PKG_SRC_DIR" \
    --prefix="$PKG_PREFIX" \
    --buildtype=release \
    -Dtests=disabled

meson compile -C "$PKG_BUILD_DIR" -j $(nproc)
meson install -C "$PKG_BUILD_DIR"

# Cleanup Build Area
cd "$REPO_DIR"
rm -rf "$PKG_BUILD_DIR"

# Create Module File
make_lua_module $PKG_NAME $PKG_VERSION
