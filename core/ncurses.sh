#!/bin/bash

# Variables
TOOL_NAME="ncurses"
export NCURSES_VERSION="6.6"
SOURCE_URL="https://ftp.gnu.org/pub/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz"
# Final destination: $INSTALL_DIR/ncurses/ncurses-6.6
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$NCURSES_VERSION"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"

# 1. Prepare Environment
mkdir -p "$SOURCE_ARCHIVE"
rm -rf /tmp/$TOOL_NAME-build
mkdir -p /tmp/$TOOL_NAME-build
cd /tmp/$TOOL_NAME-build

# 2. Download and Archive
wget -q "$SOURCE_URL" -O "${TOOL_NAME}-${NCURSES_VERSION}.tar.gz"
cp "${TOOL_NAME}-${NCURSES_VERSION}.tar.gz" "$SOURCE_ARCHIVE/"

# 3. Unpack and Build
tar -xzf "${TOOL_NAME}-${NCURSES_VERSION}.tar.gz"
cd "${TOOL_NAME}-${NCURSES_VERSION}"

# Configure
./configure --prefix="$TARGET_DIR" \
            --with-shared \
            --enable-widec \
            --enable-pc-files \
            --with-pkg-config-libdir="$TARGET_DIR/lib/pkgconfig" \
            --without-debug \
            --without-ada

make -j$(nproc)
make install

# 4. Cleanup Build Area
rm -rf /tmp/$TOOL_NAME-build

# 5. Module generation
make_lua_module "ncurses" "$NCURSES_VERSION"
