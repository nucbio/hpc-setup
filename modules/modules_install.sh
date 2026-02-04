#!/bin/bash

LMOD_VERSION=9.0.5
LMOD_ARCHIVE="lmod-${LMOD_VERSION}.tar.gz"
SOURCE_DIR="$INSTALL_DIR/sources"
BUILD_DIR="/tmp/lmod-build"

# 1. Manage Source Archive
mkdir -p "$SOURCE_DIR"
if [ ! -f "$SOURCE_DIR/$LMOD_ARCHIVE" ]; then
    wget "https://github.com/TACC/Lmod/archive/refs/tags/${LMOD_VERSION}.tar.gz" -O "$SOURCE_DIR/$LMOD_ARCHIVE"
fi

# 2. Prepare Build Directory
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi
mkdir -p "$BUILD_DIR"

# 3. Extract to Build Directory
tar -xzf "$SOURCE_DIR/$LMOD_ARCHIVE" -C "$BUILD_DIR" --strip-components=1
cd "$BUILD_DIR"

# 4. Environment Setup
eval "$($LUA_DIR/bin/luarocks path)"
export TCL_INCLUDE="-I${TCL_INSTALL}/include"
export TCL_LIBS="-L${TCL_INSTALL}/lib -ltcl8.6"
export PATH="$LUA_DIR/bin:$PATH"

# 5. Configure and Install
./configure \
    --prefix="$INSTALL_DIR" \
    --with-lua="$LUA_DIR/bin/lua" \
    --with-luac="$LUA_DIR/bin/luac" \
    --with-tcl=yes \
    --with-tclConfig="$TCL_INSTALL/lib/tclConfig.sh" \
    --with-module-root-path="$INSTALL_DIR/modulefiles" \
    --with-updateSystemFn=no

make install

# Source the new installation
source "$ISNTALL_DIR/lmod/$LMOD_VERSION/init/bash"

# Optional: Add to your shell profile for persistence
# echo "source $LMOD_INSTALL/lmod/${LMOD_VERSION}/init/bash" >> ~/.bashrc

# use for tests: unset -f module
#

