#!/bin/bash

CAIRO_VERSION="1.18.4"

LIB_DIR=$INSTALL_DIR/cairo/cairo-$CAIRO_VERSION
SRC_DIR=$LIB_DIR/src
BUILD_DIR=/tmp/cairo-build

# Create source directory and extract
mkdir -p $SRC_DIR
cd $LIB_DIR
wget https://cairographics.org/releases/cairo-$CAIRO_VERSION.tar.xz
tar -xJf cairo-$CAIRO_VERSION.tar.xz -C ${SRC_DIR} --strip-components=1

# Clean and create build directory
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}

# Configure with Meson
module use $INSTALL_DIR/modulefiles
module load meson/$MESON_VERSION
module load ninja/$NINJA_VERSION

cd ${SRC_DIR}
meson setup ${BUILD_DIR} --prefix=$LIB_DIR

# Build and install
cd ${BUILD_DIR}
ninja
ninja install

# Cleanup
rm -rf ${BUILD_DIR}
