#!/bin/bash

# Variables
OPENSSL_VERSION=3.6.1
SOURCE_DIR="$INSTALL_DIR/sources"
BUILD_DIR="/tmp/openssl-build"
OPENSSL_INSTALL_DIR="$INSTALL_DIR/openssl/openssl-$OPENSSL_VERSION"

# 1. Manage Source Archive
mkdir -p "$SOURCE_DIR"
OPENSSL_ARCHIVE="openssl-${OPENSSL_VERSION}.tar.gz"

if [ ! -f "$SOURCE_DIR/$OPENSSL_ARCHIVE" ]; then
    wget "https://github.com/openssl/openssl/releases/download/openssl-$OPENSSL_VERSION/$OPENSSL_ARCHIVE" \
      -O "$SOURCE_DIR/$OPENSSL_ARCHIVE"
fi

# 2. Prepare Build Directory
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi
mkdir -p "$BUILD_DIR"

# 3. Extract to Build Directory
tar -xf "$SOURCE_DIR/$OPENSSL_ARCHIVE" -C "$BUILD_DIR" --strip-components=1
cd "$BUILD_DIR"

# 4. Configure
# Note: --openssldir is usually for configuration files/certs. 
# Keeping it inside the prefix keeps the installation self-contained.
./configure \
    --prefix="$OPENSSL_INSTALL_DIR" \
    --openssldir="$OPENSSL_INSTALL_DIR" \
    shared \
    linux-x86_64

# 5. Build and Install
make -j$(nproc) 
make install

# Modules
make_lua_module "openssl" "$OPENSSL_VERSION"
