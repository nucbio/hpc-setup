#!/bin/bash

# Variables
PKG_NAME="samtools"
PKG_VERSION="1.23"
PKG_SRC_URL="https://github.com/samtools/samtools/releases/download/${TOOL_VERSION}/samtools-${TOOL_VERSION}.tar.bz2"
PKG_ARCHIVE="$SOURCES/${TOOL_NAME}_v${TOOL_VERSION}.tar.bz2"

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
tar -xjf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

cd "$PKG_BUILD_DIR"
"$PKG_SRC_DIR/configure" \
    --prefix="$PKG_PREFIX"
    --with-libcurl \
    --enable-plugins \
    --with-htslib="$INSTALL_DIR/htslib/htslib-$HTSLIB_VERSION"

make -j$(nproc)
make install

# Cleanup Build Area
cd "$REPO_DIR"
rm -rf "$PKG_BUILD_DIR"

# Create Module File
make_lua_module $PKG_NAME $PKG_VERSION "$PKG_PREFIX/bin"

