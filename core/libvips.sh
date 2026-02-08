#!/bin/bash

export LIBVIPS_VERSION="8.18.0"

PKG_VERSION="$LIBVIPS_VERSION"
PKG_NAME="libvips"
PKG_SRC_URL="https://github.com/libvips/libvips/releases/download/v$LIBVIPS_VERSION/vips-$LIBVIPS_VERSION.tar.xz"
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.xz"

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
tar -xJf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

# FIX: distutils is needed but depricated 
export SETUPTOOLS_USE_DISTUTILS=local

meson setup "$PKG_BUILD_DIR" "$PKG_SRC_DIR" \
    --prefix="$PKG_PREFIX" \
    --buildtype=release \
    -Dintrospection=disabled \
    -Dmatio=disabled \
    -Dcfitsio=disabled \
    -Dpdfium=disabled \
    -Dmagick=disabled

meson compile -C "$PKG_BUILD_DIR" -j $(nproc)
meson install -C "$PKG_BUILD_DIR"

# Cleanup Build Area
cd "$REPO_DIR"
rm -rf "$PKG_BUILD_DIR"

# Create Module File
make_lua_module $PKG_NAME $PKG_VERSION
