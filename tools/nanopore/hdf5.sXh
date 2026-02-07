#!/bin/bash
# Configuration
TOOL_NAME="hdf5"
export HDF5_VERSION="1.14.6"
SOURCE_URL="https://support.hdfgroup.org/releases/$TOOL_NAME/v1_14/v1_14_6/downloads/$TOOL_NAME-$HDF5_VERSION.tar.gz"

TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$HDF5_VERSION"
ARCHIVE="$TOOL_NAME-$HDF5_VERSION.tar.gz"
BUILD_DIR="/tmp/hdf5-build"

# Create directories
rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR
cd $BUILD_DIR
wget -qL $SOURCE_URL -O $ARCHIVE
tar -xzf $ARCHIVE
cd "$TOOL_NAME-$HDF5_VERSION"

# Test environment
env | grep -E 'CFLAGS|CPPFLAGS|CXXFLAGS|LDFLAGS' > $INSTALL_DIR/envir_vars.txt

./configure --prefix=$TARGET_DIR --enable-build-mode=production

# Alternative configure
# ./configure \
#     --prefix="$TARGET_DIR" \
#     --enable-build-mode=production \
#     --enable-threadsafe \
#     --enable-unsupported \
#     --enable-shared \
#     --enable-cxx \
#     --with-pic \
#     --with-zlib

make -j 4
make install

cd $REPO_DIR
# rm -rf "$BUILD_DIR"

# Module
make_lua_module "$TOOL_NAME" "$HDF5_VERSION"
