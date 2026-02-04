#!/bin/bash

# Load dependencies
module use $INSTALL_DIR/modulefiles
module load openssl/$OPENSSL_VERSION
module load readline/$READLINE_VERSION
module load ncurses/$NCURSES_VERSION
module load xz/$XZ_VERSION
module load bzip2/$BZIP2_VERSION
module load libcurl/$LIBCURL_VERSION
module load sqlite/$SQLITE_VERSION

# Variables
PYTHON_VERSION=3.12.2
SOURCE_DIR="$INSTALL_DIR/sources"
BUILD_DIR="/tmp/python-build"
TARGET_DIR="$INSTALL_DIR/python/python-$PYTHON_VERSION"

# 1. Manage Source Archive
mkdir -p "$SOURCE_DIR"
PYTHON_ARCHIVE="Python-$PYTHON_VERSION.tgz"

if [ ! -f "$SOURCE_DIR/$PYTHON_ARCHIVE" ]; then
    wget "https://www.python.org/ftp/python/$PYTHON_VERSION/$PYTHON_ARCHIVE" -O "$SOURCE_DIR/$PYTHON_ARCHIVE"
fi

# 2. Prepare Build Directory
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi
mkdir -p "$BUILD_DIR"

# 3. Extract to Build Directory
tar -xf "$SOURCE_DIR/$PYTHON_ARCHIVE" -C "$BUILD_DIR" --strip-components=1
cd "$BUILD_DIR"

# 4. Configure
# Note: Ensure $PKG_DIR and $NCPU are defined in your environment
./configure \
    --prefix="$TARGET_DIR" \
    --with-openssl="$PKG_DIR/openssl/$OPENSSL_DIR" \
    --enable-optimizations \
    --with-ensurepip=install

# 5. Build and Install
make -j$(nproc)
make install

# Optional: Cleanup build directory after successful install
# rm -rf "$BUILD_DIR"

make_lua_module "python" "$PYTHON_VERSION"
