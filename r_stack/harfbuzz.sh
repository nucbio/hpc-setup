#!/bin/bash

HARFBUZZ_VERSION="12.2.0"

LIB_DIR=$INSTALL_DIR/harfbuzz/harfbuzz-$HARFBUZZ_VERSION
SRC_DIR=$LIB_DIR/src
BUILD_DIR=/tmp/harfbuzz-build
mkdir -p $SRC_DIR
cd $LIB_DIR

wget https://github.com/harfbuzz/harfbuzz/releases/download/$HARFBUZZ_VERSION/harfbuzz-$HARFBUZZ_VERSION.tar.xz
tar -xJf harfbuzz-$HARFBUZZ_VERSION.tar.xz -C $SRC_DIR --strip-components=1
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}
meson setup $BUILD_DIR $SRC_DIR --prefix=$LIB_DIR
# Build and install
meson compile -C $BUILD_DIR
meson install -C $BUILD_DIR
rm -rf $BUILD_DIR

# Modules
make_lua_module "harfbuzz" "$HARFRBUZZ_VERSION"
