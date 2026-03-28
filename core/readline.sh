#!/bin/bash

echo "Install readline"

export READLINE_VERSION="8.3"

PKG_VERSION=$READLINE_VERSION
PKG_NAME="readline"

PKG_URL="https://ftp.gnu.org/pub/gnu/readline/readline-${READLINE_VERSION}.tar.gz"
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.gz"

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

cd "$PKG_BUILD_DIR"
"$PKG_SRC_DIR/configure" \
    --prefix="$PKG_PREFIX" \
    --with-curses

make clean
make SHLIB_LIBS="-lncursesw"
make install

# Cleanup Build Area
cd "$REPO_DIR"
rm -rf "$PKG_BUILD_DIR"

# Create Module File
module_templater "$PKG_NAME"
