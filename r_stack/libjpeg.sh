#!/bin/bash

# https://github.com/libjpeg-turbo/libjpeg-turbo/releases
LIBJPEG_VERSION="3.1.2"
LIB_DIR=$INSTALL_DIR/libjpeg/libjpeg-$LIBJPEG_VERSION
SRC_DIR=$LIB_DIR/src
BUILD_DIR=/tmp/libjpeg-build
mkdir -p $SRC_DIR
cd $LIB_DIR
wget https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/$LIBJPEG_VERSION/libjpeg-turbo-$LIBJPEG_VERSION.tar.gz
tar -xzf libjpeg-turbo-$LIBJPEG_VERSION.tar.gz -C ${SRC_DIR} --strip-components=1
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}
# Configure and build with proper settings
cmake -S $SRC_DIR -B $BUILD_DIR \
  -DCMAKE_INSTALL_PREFIX=$LIB_DIR
cmake --build $BUILD_DIR -j$(nproc) 
cmake --install $BUILD_DIR
