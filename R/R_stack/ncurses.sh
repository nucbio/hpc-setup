#!/bin/bash
# Variables
TOOL_NAME="ncurses"
NCURSES_VERSION="6.6" 
SOURCE_URL="https://ftp.gnu.org/pub/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME"

mkdir -p $TARGET_DIR
cd $TARGET_DIR
# Download and Unpack
wget -q "$SOURCE_URL" -O ncurses-$NCURSES_VERSION.tar.gz
tar -xzf ncurses-$NCURSES_VERSION.tar.gz
cd ncurses-${NCURSES_VERSION}

# Configure and Install
./configure --prefix="$TARGET_DIR" \
            --with-shared \
            --enable-widec \
            --enable-pc-files \
            --with-pkg-config-libdir="$TARGET_DIR/$TOOL_NAME-$NCURSES_VERSION/lib/pkgconfig"

make -j$(nproc)
make install

# Clean up
cd .. && rm -rf ncurses-${NCURSES_VERSION}

# Modules
make_lua_module "ncurses" "$NCURSES_VERSION"
