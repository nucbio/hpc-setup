#!/bin/bash

# Test bzip2 to keep structure
# Variables
export BZIP2_VERSION="1.0.8"
TOOL_NAME="bzip2"
SOURCE_URL="https://gitlab.com/bzip2/bzip2/-/archive/bzip2-$BZIP2_VERSION/bzip2-bzip2-$BZIP2_VERSION.tar.gz"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/bzip2-$BZIP2_VERSION"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"

# 1. Prepare Environment
mkdir -p "$SOURCE_ARCHIVE"
rm -rf /tmp/$TOOL_NAME-build
mkdir -p /tmp/$TOOL_NAME-build
cd /tmp/$TOOL_NAME-build

# 2. Download and Archive
wget -q "$SOURCE_URL" -O "${TOOL_NAME}-${BZIP2_VERSION}.tar.gz"
cp "${TOOL_NAME}-${BZIP2_VERSION}.tar.gz" "$SOURCE_ARCHIVE/"

# 3. Unpack
tar -xzf "${TOOL_NAME}-${BZIP2_VERSION}.tar.gz"
cd bzip2-bzip2-$BZIP2_VERSION

# 4. Build Shared Library
# bzip2 requires a separate make command for the shared object
make -f Makefile-libbz2_so
make clean

# 5. Build and Install Static/Binaries
# Since bzip2 doesn't have ./configure, we pass PREFIX directly to make
make -j$(nproc) PREFIX="$TARGET_DIR" LDFLAGS="$LDFLAGS"
make install PREFIX="$TARGET_DIR"

# 6. Manually copy the shared library (Makefile-libbz2_so doesn't do this)
cp libbz2.so.${BZIP2_VERSION} "$TARGET_DIR/lib/"
ln -sf libbz2.so.${BZIP2_VERSION} "$TARGET_DIR/lib/libbz2.so.1.0"
ln -sf libbz2.so.1.0 "$TARGET_DIR/lib/libbz2.so"

# 7. Cleanup Build Area
rm -rf /tmp/$TOOL_NAME-build

# 8. Module generation
make_lua_module "bzip2" "$BZIP2_VERSION"
