#!/bin/bash

LIBWEBP_VERSION="1.6.0"

# from github mirror get tar.gz
LIB_DIR=$INSTALL_DIR/libwebp/libwebp-$LIBWEBP_VERSION
SRC_DIR=$LIB_DIR/src
BUILD_DIR=/tmp/libwebp-build
mkdir -p $SRC_DIR
cd $LIB_DIR
wget https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-$LIBWEBP_VERSION.tar.gz
tar -xzf libwebp-$LIBWEBP_VERSION.tar.gz -C ${SRC_DIR} --strip-components=1
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}
cmake -S $SRC_DIR -B $BUILD_DIR \
  -DCMAKE_INSTALL_PREFIX=$LIB_DIR \
  -DWEBP_ENABLE_SHARPYUV=ON \
  -DBUILD_SHARED_LIBS=ON
cmake --build $BUILD_DIR -j 4
cmake --install $BUILD_DIR
rm -rf $BUILD_DIR
