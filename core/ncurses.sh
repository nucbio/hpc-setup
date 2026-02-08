#!/bin/bash

# Variables
PKG_NAME="ncurses"
export NCURSES_VERSION="6.6"
PKG_SRC_URL="https://ftp.gnu.org/pub/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz"
# Final destination: $INSTALL_DIR/ncurses/ncurses-6.6
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$NCURSES_VERSION"
PKG_ARCHIVE="$INSTALL_DIR/sources"

# 1. Prepare Environment
mkdir -p "$PKG_ARCHIVE"
rm -rf /tmp/$PKG_NAME-build
mkdir -p /tmp/$PKG_NAME-build
cd /tmp/$PKG_NAME-build

# 2. Download and Archive
wget -q "$PKG_SRC_URL" -O "${PKG_NAME}-${NCURSES_VERSION}.tar.gz"
cp "${PKG_NAME}-${NCURSES_VERSION}.tar.gz" "$PKG_ARCHIVE/"

# 3. Unpack and Build
tar -xzf "${PKG_NAME}-${NCURSES_VERSION}.tar.gz"
cd "${PKG_NAME}-${NCURSES_VERSION}"

# Configure
./configure --prefix="$PKG_PREFIX" \
            --with-shared \
            --enable-widec \
            --enable-pc-files \
            --with-pkg-config-libdir="$PKG_PREFIX/lib/pkgconfig" \
            --without-debug \
            --without-ada

make -j$(nproc)
make install

# 4. Cleanup Build Area
rm -rf /tmp/$PKG_NAME-build

# 5. Module generation
make_lua_module "ncurses" "$NCURSES_VERSION"
