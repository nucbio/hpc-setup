#!/bin/bash

PKG_NAME="samtools"
PKG_VERSION=$(pkg_version "$PKG_NAME")
PKG_URL=$(pkg_url "$PKG_NAME")
PKG_ARCHIVE="$SOURCES_DIR/$PKG_NAME-$PKG_VERSION.tar.bz2"

# Set PKG_SCR_DIR, PKG_PREFIX
set_pkg_dirs  $PKG_NAME $PKG_VERSION

wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
tar -xjf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

cd "$PKG_SRC_DIR"

# Samtools configure works from source dir, not from build
# htslib is already in samtools (--with-htslib is optional)
./configure \
    --prefix="$PKG_PREFIX" \
    --with-libcurl \
    --enable-plugins \
    --with-htslib="$INSTALL_DIR/htslib/htslib-$HTSLIB_VERSION"

make -j $(nproc)
make install

cd "$REPO_DIR"
rm -rf "$PKG_SRC_DIR"

# Create Module file
module_templater "$PKG_NAME"

