#!/bin/bash

# Variables
TOOL_NAME="samtools"
TOOL_VERSION="1.23"
SOURCE_URL="https://github.com/samtools/samtools/releases/download/${TOOL_VERSION}/samtools-${TOOL_VERSION}.tar.bz2"
ARCHIVE_NAME="${TOOL_NAME}_v${TOOL_VERSION}.tar.bz2"

# Paths
SOURCE_PATH="$INSTALL_DIR/sources/$ARCHIVE_NAME"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$TOOL_VERSION"
BUILD_DIR="$TARGET_DIR/build"

# Download to sources directory
wget -q "$SOURCE_URL" -O "$SOURCE_PATH"

# Create target directory and unpack
mkdir -p "$TARGET_DIR"
tar -xjf "$SOURCE_PATH" -C "$TARGET_DIR" --strip-components=1

# Configure, Build, and Install
cd "$TARGET_DIR"
mkdir -p "$BUILD_DIR"

# Should be available from modules
#export CPPFLAGS="-I/home/suvar/test_install/openssl/openssl-3.6.1/include"
#export LDFLAGS="-L/home/suvar/test_install/openssl/openssl-3.6.1/lib64 -Wl,-rpath,/home/suvar/test_install/openssl/openssl-3.6.1/lib64"

./configure --prefix="$BUILD_DIR" \
            --with-libcurl \
            --enable-plugins \
            --with-htslib="$INSTALL_DIR/htslib/htslib-$HTSLIB_VERSION"
# check pkg-config
# add --with-htslib=$INSTALL_DIR/htslib-1.2
# Running configure with your specific requirement
#./configure --disable-bz2 --without-curses --prefix="$BUILD_DIR"

# Build and install into the --prefix path
make -j$(nproc)
make install

# Modules lua file
make_lua_module "$TOOL_NAME" "$TOOL_VERSION" "$BUILD_DIR/bin"

