#!/bin/bash
# Variables
TOOL_NAME="readline"
READLINE_VERSION="8.2"
SOURCE_URL="https://ftp.gnu.org/pub/gnu/readline/readline-${READLINE_VERSION}.tar.gz"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$READLINE_VERSION"
NCURSES_DIR="$INSTALL_DIR/ncurses/ncurses-$NCURSES_VERSION"

# Download and Unpack
wget -q "$SOURCE_URL" -O readline.tar.gz
tar -xzf readline.tar.gz
cd readline-${READLINE_VERSION}

# Configure and Install
# We link to ncurses so readline knows how to handle the terminal
./configure --prefix="$TARGET_DIR" \
            --with-curses="$NCURSES_DIR" \
            CPPFLAGS="-I$NCURSES_DIR/include" \
            LDFLAGS="-L$NCURSES_DIR/lib"

make -j$(nproc)
make install

# Clean up
cd .. && rm -rf readline-${READLINE_VERSION} readline.tar.gz

# Module
make_lua_module "readline" "$READLINE_VERSION"
