#!/bin/bash
# Variables
SQLITE_ID=3510200
export SQLITE_VERSION=3.51
SQLITE_YEAR=2026
SOURCE_DIR="$INSTALL_DIR/sources"
BUILD_DIR="/tmp/sqlite-build"
SQLITE_INSTALL_DIR="$INSTALL_DIR/sqlite/$SQLITE_VERSION"

# 1. Manage Source Archive
mkdir -p "$SOURCE_DIR"
SQLITE_ARCHIVE="sqlite-autoconf-${SQLITE_ID}.tar.gz"

if [ ! -f "$SOURCE_DIR/$SQLITE_ARCHIVE" ]; then
    wget "https://www.sqlite.org/${SQLITE_YEAR}/${SQLITE_ARCHIVE}" -O "$SOURCE_DIR/$SQLITE_ARCHIVE"
fi

# 2. Prepare Build Directory
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi
mkdir -p "$BUILD_DIR"

# 3. Extract to Build Directory
tar -xf "$SOURCE_DIR/$SQLITE_ARCHIVE" -C "$BUILD_DIR" --strip-components=1
cd "$BUILD_DIR"

# 4. Configure
./configure --prefix="$SQLITE_INSTALL_DIR"

# 5. Build and Install
make -j$(nproc)
make install

# Module
make_lua_module "sqlite" "$SQLITE_VERSION"
