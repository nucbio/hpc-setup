#!/bin/bash

# Variables
TOOL_NAME="htslib"
export HTSLIB_VERSION="1.21"
SOURCE_URL="https://github.com/samtools/htslib/releases/download/${HTSLIB_VERSION}/htslib-${HTSLIB_VERSION}.tar.bz2"
ARCHIVE_NAME="${TOOL_NAME}_v${HTSLIB_VERSION}.tar.bz2"

# Paths
SOURCE_PATH="$INSTALL_DIR/sources/$ARCHIVE_NAME"
# Final destination (where the libraries/bins will live)
FINAL_DEST="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$HTSLIB_VERSION"
# Temporary build location
TEMP_BUILD_DIR="/tmp/htslib-build"

# 1. Cleanup old build remnants
if [ -d "$TEMP_BUILD_DIR" ]; then
    echo "Removing existing temporary build directory: $TEMP_BUILD_DIR"
    cd $REPO_DIR
    rm -rf "$TEMP_BUILD_DIR"
fi

# 2. Download to sources directory if not already there
wget -q "$SOURCE_URL" -O "$SOURCE_PATH"

# 3. Create temporary build directory and unpack
mkdir -p "$TEMP_BUILD_DIR"
tar -xjf "$SOURCE_PATH" -C "$TEMP_BUILD_DIR" --strip-components=1

# 4. Configure, Build, and Install
cd "$TEMP_BUILD_DIR"

# Configure HTSlib
./configure --prefix="$FINAL_DEST" \
            --enable-libcurl \
            --enable-plugins

# Build and install
make -j$(nproc)
make install

# 5. Generate Modulefile
make_lua_module "$TOOL_NAME" "$HTSLIB_VERSION"

# Cleanup /tmp after successful install
cd $REPO_DIR
rm -rf "$TEMP_BUILD_DIR"
