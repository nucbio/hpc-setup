#!/bin/bash

module load pandoc/$PANDOC_VERSION

export OPENSSL_VERSION="3.6.1"
PKG_VERSION=$OPENSSL_VERSION
PKG_NAME="openssl"
OPENSSL_ARCHIVE="openssl-${OPENSSL_VERSION}.tar.gz"
PKG_URL="https://github.com/openssl/openssl/releases/download/openssl-$OPENSSL_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.gz"

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1


cd "$PKG_BUILD_DIR"
"$PKG_SRC_DIR/Configure" \
    --prefix="$PKG_PREFIX" \
    --openssldir="$PKG_PREFIX" \
    shared \
    linux-x86_64

make -j$(nproc)
make install

# Cleanup Build Area
cd "$REPO_DIR"
rm -rf "$PKG_BUILD_DIR"

# Create Module File
make_lua_module "$PKG_NAME" "$PKG_VERSION"
