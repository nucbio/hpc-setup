#!/bin/bash

INSTALL_DIR=/home/suvar/test_install
mkdir -p $INSTALL_DIR/sources
# Variables
LUA_VERSION="5.5.0"
LUA_DIR="$INSTALL_DIR/lua/lua-$LUA_VERSION"
SOURCE_DIR="$INSTALL_DIR/sources"

# Download Lua
cd "$SOURCE_DIR"
wget https://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz
tar -xzf lua-${LUA_VERSION}.tar.gz
cd "lua-${LUA_VERSION}"

# Extract and Build
tar zxf "lua-$LUA_VERSION.tar.gz"
cd "lua-$LUA_VERSION"

# Build for Linux and install to the local target
mkdir -p "$LUA_DIR"
make linux
make install INSTALL_TOP="$LUA_DIR"

# Cleanup source folder
cd ..
rm -rf "lua-$LUA_VERSION"
