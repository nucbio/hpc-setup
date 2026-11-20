#!/bin/bash

# Variables
LUA_VERSION=$(pkg_version "lua")
export LUA_VERSION
LUA_DIR="$INSTALL_DIR/lua/lua-$LUA_VERSION"
SOURCE_DIR="$INSTALL_DIR/sources"

# Download Lua
cd "$SOURCE_DIR"
wget "$(pkg_url lua)" -O "lua-${LUA_VERSION}.tar.gz"
tar -xzf "lua-${LUA_VERSION}.tar.gz"
cd "lua-$LUA_VERSION"

# Build for Linux and install to the local target
mkdir -p "$LUA_DIR"
make linux
make install INSTALL_TOP="$LUA_DIR"

# Cleanup source folder
cd ..
rm -rf "lua-$LUA_VERSION"

# Export
export PATH="$LUA_DIR/bin:$PATH"

module_templater "lua"
