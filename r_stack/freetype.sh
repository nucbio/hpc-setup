#!/bin/bash

FREETYPE_VERSION=2.14.1

LIB_DIR=$INSTALL_DIR/freetype/freetype-$FREETYPE_VERSION
SRC_DIR=$LIB_DIR/src
BUILD_DIR=/tmp/freetype-build
mkdir -p $SRC_DIR
cd $LIB_DIR
wget https://download.savannah.gnu.org/releases/freetype/freetype-$FREETYPE_VERSION.tar.gz
tar -xzf freetype-$FREETYPE_VERSION.tar.gz -C ${SRC_DIR} --strip-components=1
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}
meson setup $BUILD_DIR $SRC_DIR --prefix=$LIB_DIR
# Build and install
meson compile -C $BUILD_DIR
meson install -C $BUILD_DIR
rm -rf $BUILD_DIR

# Modules

make_lua_module "freetype" "$FREETYPE_VERSION" "$LIB_DIR/bin"
