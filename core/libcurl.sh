#!/bin/bash

export LIBCURL_VERSION="8.17.0"
PKG_VERSION=$LIBCURL_VERSION
PKG_NAME="libcurl"
PKG_SRC_URL="https://curl.se/download/curl-$LIBCURL_VERSION.tar.gz"
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.gz"

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

cd "$PKG_BUILD_DIR"
"$PKG_SRC_DIR/configure" \
    --prefix="$PKG_PREFIX" \
    --enable-shared \
    --enable-static \
    --enable-optimize \
    --disable-manual \
    --disable-ldap \
    --disable-ldaps \
    --without-libpsl \
    --with-openssl
    #="$INSTALL_DIR/openssl/openssl-$OPENSSL_VERSION"

make -j$(nproc)
make install

# Cleanup Build Area
cd "$REPO_DIR"
rm -rf "$PKG_BUILD_DIR"

# Create Module File
make_lua_module $PKG_NAME $PKG_VERSION
