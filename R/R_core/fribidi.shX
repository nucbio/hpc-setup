#!/bin/bash

# https://github.com/fribidi/fribidi/releases
FRIBIDI_VERSION="1.0.16"

LIB_DIR=$INSTALL_DIR/fribidi/fribidi-$FRIBIDI_VERSION
SRC_DIR=$LIB_DIR/src
BUILD_DIR=/tmp/fribidi-build
mkdir -p $SRC_DIR
cd $LIB_DIR
wget https://github.com/fribidi/fribidi/releases/download/v$FRIBIDI_VERSION/fribidi-$FRIBIDI_VERSION.tar.xz
tar -xJf fribidi-$FRIBIDI_VERSION.tar.xz -C $SRC_DIR --strip-components=1
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}
${SRC_DIR}/configure --prefix=$LIB_DIR
make && make install
rm -rf $BUILD_DIR

# Modules
make_lua_module "fribidi" "$FRIBIDI_VERSION"
