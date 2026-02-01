#!/bin/bash

LUAROCK_VERSION="3.13.0"
ROCKS_INSTALL_DIR="$INSTALL_DIR/lua/luarock-$LUAROCK_VERSION"
SOURCE_DIR="$INSTALL_DIR/sources"

# Download and Unpack
cd "$SOURCE_DIR"
wget -N "https://luarocks.github.io/luarocks/releases/luarocks-$LUAROCK_VERSION-linux-x86_64.zip"
unzip -oj "luarocks-$LUAROCK_VERSION-linux-x86_64.zip" -d "extracted_rocks"

# 2. Move to target directory
mkdir -p "$ROCKS_INSTALL_DIR/bin"
mv extracted_rocks/luarocks extracted_rocks/luarocks-admin "$ROCKS_INSTALL_DIR/bin/"
rm -rf extracted_rocks

# Ensure PATH is set
export PATH="$ROCKS_INSTALL_DIR/bin:$LUA_DIR/bin:$PATH"

# Configure luarocks to use the correct Lua installation
luarocks --local config variables.LUA "$LUA_DIR/bin/lua"
luarocks --local config variables.LUA_INCDIR "$LUA_DIR/include"
luarocks --local config variables.LUA_LIBDIR "$LUA_DIR/lib"

# install luasocket
luarocks --local install luasocket

$LUA_DIR/bin/luarocks install luaposix
$LUA_DIR/bin/luarocks install luafilesystem
