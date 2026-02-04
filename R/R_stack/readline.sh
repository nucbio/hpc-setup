#!/bin/bash
# Variables
TOOL_NAME="readline"
READLINE_VERSION="8.3"
SOURCE_URL="https://ftp.gnu.org/pub/gnu/readline/readline-${READLINE_VERSION}.tar.gz"
# Keep the target directory clean (no version subfolders inside)
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$READLINE_VERSION"
NCURSES_DIR="$INSTALL_DIR/ncurses/ncurses-$NCURSES_VERSION"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"

# 1. Prepare Environment
mkdir -p "$SOURCE_ARCHIVE"
rm -rf /tmp/readline-build
mkdir -p /tmp/readline-build
cd /tmp/readline-build

# 2. Download and Archive
wget -q "$SOURCE_URL" -O "readline-${READLINE_VERSION}.tar.gz"
cp "readline-${READLINE_VERSION}.tar.gz" "$SOURCE_ARCHIVE/"

# 3. Unpack and Build
tar -xzf "readline-${READLINE_VERSION}.tar.gz"
cd "readline-${READLINE_VERSION}"

# Explicit ncurses variaables
export CPPFLAGS="-I$NCURSES_DIR/include"
export LDFLAGS="-L$NCURSES_DIR/lib"
export PKG_CONFIG_PATH="$NCURSES_DIR/lib/pkgconfig"

./configure --prefix="$TARGET_DIR" \
            --with-curses="$NCURSES_DIR" \
            CPPFLAGS="-I$NCURSES_DIR/include" \
            LDFLAGS="-L$NCURSES_DIR/lib" \
            --enable-shared \
            --enable-static

make -j$(nproc)
make install

# Cleanup Build Area
rm -rf /tmp/readline-build

# Module generation
make_lua_module "readline" "$READLINE_VERSION"

