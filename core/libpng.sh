#!/bin/bash

export LIBPNG_VERSION="1.6.50"

LIB_DIR=$INSTALL_DIR/libpng/libpng-$LIBPNG_VERSION
SRC_DIR=$LIB_DIR/src
BUILD_DIR=/tmp/libpng-build
mkdir -p $SRC_DIR
cd $LIB_DIR

wget https://downloads.sourceforge.net/libpng/libpng-$LIBPNG_VERSION.tar.gz
tar -xzf libpng-$LIBPNG_VERSION.tar.gz -C ${SRC_DIR} --strip-components=1
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}
${SRC_DIR}/configure --prefix=$LIB_DIR
make && make install
rm -rf $BUILD_DIR

# Modules
make_lua_module "libpng" "$LIBPNG_VERSION"
