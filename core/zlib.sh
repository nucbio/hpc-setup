#!/bin/bash

# Variables
TOOL_NAME="zlib"
export ZLIB_VERSION="1.3.1"
SOURCE_URL="https://zlib.net/zlib-${ZLIB_VERSION}.tar.gz"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$ZLIB_VERSION"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"

# 1. Prepare Environment
mkdir -p "$SOURCE_ARCHIVE"
rm -rf /tmp/$TOOL_NAME-build
mkdir -p /tmp/$TOOL_NAME-build
cd /tmp/$TOOL_NAME-build

# 2. Download and Archive
wget -q "$SOURCE_URL" -O "${TOOL_NAME}-${ZLIB_VERSION}.tar.gz"
cp "${TOOL_NAME}-${ZLIB_VERSION}.tar.gz" "$SOURCE_ARCHIVE/"

# 3. Unpack and Build
tar -xzf "${TOOL_NAME}-${ZLIB_VERSION}.tar.gz"
cd "${TOOL_NAME}-${ZLIB_VERSION}"

# Configure
# zlib's configure is simpler than others but respects --prefix
./configure --prefix="$TARGET_DIR"

make -j$(nproc)
make install

# 4. Cleanup Build Area
rm -rf /tmp/$TOOL_NAME-build

# 5. Module generation
make_lua_module "zlib" "$ZLIB_VERSION"
