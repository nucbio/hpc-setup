#!/bin/bash
# Variables
PKG_NAME="readline"
export READLINE_VERSION="8.3"
PKG_SRC_URL="https://ftp.gnu.org/pub/gnu/readline/readline-${READLINE_VERSION}.tar.gz"
# Keep the target directory clean (no version subfolders inside)
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$READLINE_VERSION"
NCURSES_DIR="$INSTALL_DIR/ncurses/ncurses-$NCURSES_VERSION"
PKG_ARCHIVE="$INSTALL_DIR/sources"

# 1. Prepare Environment
mkdir -p "$PKG_ARCHIVE"
rm -rf /tmp/readline-build
mkdir -p /tmp/readline-build
cd /tmp/readline-build

# 2. Download and Archive
wget -q "$PKG_SRC_URL" -O "readline-${READLINE_VERSION}.tar.gz"
cp "readline-${READLINE_VERSION}.tar.gz" "$PKG_ARCHIVE/"

# 3. Unpack and Build
tar -xzf "readline-${READLINE_VERSION}.tar.gz"
cd "readline-${READLINE_VERSION}"

./configure --prefix=$PKG_PREFIX --with-curses

make clean
make SHLIB_LIBS="-lncursesw"
make install

# Cleanup Build Area
rm -rf /tmp/readline-build

# Module generation
make_lua_module "readline" "$READLINE_VERSION"

