#!/bin/bash
# Configuration
TOOL_NAME="hdf5"
export HDF5_VERSION="2.0.0"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$HDF5_VERSION"
ARCHIVE="hdf5-$HDF5_VERSION.tar.gz"
BUILD_DIR="/tmp/hdf5-build"
SOURCE_URL="https://github.com/HDFGroup/hdf5/archive/refs/tags/2.0.0.tar.gz"
# Create directories
rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR
cd $BUILD_DIR

wget -L $SOURCE_URL -O $ARCHIVE
tar -xzf $ARCHIVE
cd "$TOOL_NAME-$HDF5_VERSION"

# Create a build subdirectory for CMake
mkdir build && cd build

# Configure with CMake (equivalent to your options)
cmake .. -DCMAKE_INSTALL_PREFIX=$TARGET_DIR -DCMAKE_BUILD_TYPE=Release

# Build and install
cmake --build . --parallel $(nproc)  # Use parallel build for speed
cmake --install .
# Module
make_lua_module "$TOOL_NAME" "$HDF5_VERSION"
