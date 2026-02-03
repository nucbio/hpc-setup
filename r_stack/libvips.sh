#!/bin/bash

LIBVIPS_VERSION="8.17.3"

# https://github.com/libvips/libvips
LIB_DIR=$INSTALL_DIR/libvips/libvips-$LIBVIPS_VERSION
SRC_DIR=$LIB_DIR/src
BUILD_DIR=/tmp/libvips-build
mkdir -p $SRC_DIR
cd $LIB_DIR

wget https://github.com/libvips/libvips/archive/refs/tags/v$LIBVIPS_VERSION.tar.gz \
  -O libvips-$LIBVIPS_VERSION.tar.gz
tar -xzf libvips-$LIBVIPS_VERSION.tar.gz -C ${SRC_DIR} --strip-components=1
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}
meson setup $BUILD_DIR $SRC_DIR --prefix=$LIB_DIR
# Build and install
meson compile -C $BUILD_DIR
meson install -C $BUILD_DIR
rm -rf $BUILD_DIR

# Modules
make_lua_module "libvips" "$LIBVIPS_VERSION"
