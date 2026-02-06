#!/bin/bash
# Configuration
export HDF5_VERSION="1.14.6"

BUILD_DIR="/tmp/hdf5-build-$$"

# Create directories
mkdir -p "$INSTALL_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"
wget https://support.hdfgroup.org/releases/hdf5/v1_14/v1_14_6/downloads/hdf5-$HDF5_VERSION.tar.gz
tar -xzf "hdf5-${HDF5_VERSION}.tar.gz"
cd "hdf5-${HDF5_VERSION}"
./configure --prefix="$INSTALL_DIR" --enable-build-mode=production

# Alternative configure
# ./configure \
#     --prefix="$INSTALL_DIR" \
#     --enable-build-mode=production \
#     --enable-threadsafe \
#     --enable-unsupported \
#     --with-pic \
#     --enable-shared \
#     --enable-cxx

make # -j may cause error
make install

cd /
rm -rf "$BUILD_DIR"
