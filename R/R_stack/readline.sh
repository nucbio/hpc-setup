#!/bin/bash
# Variables
TOOL_NAME="readline"
READLINE_VERSION="8.2"
SOURCE_URL="https://ftp.gnu.org/pub/gnu/readline/readline-${READLINE_VERSION}.tar.gz"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME"
NCURSES_DIR="$INSTALL_DIR/ncurses/ncurses-$NCURSES_VERSION"

mkdir -p $TARGET_DIR
cd $TARGET_DIR
# Download and Unpack
wget -q "$SOURCE_URL" -O readline-$READLINE_VERSION.tar.gz
tar -xzf readline-$READLINE_VERSION.tar.gz
cd readline-${READLINE_VERSION}

# Configure and Install
# We link to ncurses so readline knows how to handle the terminal
./configure --prefix="$TARGET_DIR/readline-$READLINE_VERSION" \
            --with-curses="$NCURSES_DIR" \
            CPPFLAGS="-I$NCURSES_DIR/include" \
            LDFLAGS="-L$NCURSES_DIR/lib"

make -j$(nproc)
make install

# Module
make_lua_module "readline" "$READLINE_VERSION"
