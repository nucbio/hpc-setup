#!/bin/bash

PKG_NAME="samtools"
PKG_VERSION="1.23"
PKG_URL="https://github.com/samtools/samtools/releases/download/${PKG_VERSION}/samtools-${PKG_VERSION}.tar.bz2"

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

