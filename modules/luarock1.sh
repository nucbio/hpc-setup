#!/bin/bash

LUAROCKS_VERSION="3.13.0" # Latest stable
cd "$SOURCE_DIR"

# Download source
wget https://luarocks.github.io/luarocks/releases/luarocks-${LUAROCKS_VERSION}.tar.gz
tar -xzf luarocks-${LUAROCKS_VERSION}.tar.gz
cd luarocks-${LUAROCKS_VERSION}

# Configure to point specifically to your local Lua
./configure \
    --prefix="$LUA_DIR" \
    --with-lua="$LUA_DIR" \
    --with-lua-include="$LUA_DIR/include" \
    --with-lua-lib="$LUA_DIR/lib"

make
make install

# Clean up
cd ..
rm -rf luarocks-${LUAROCKS_VERSION}

# Install Lua Packages
$LUAROCKS=$LUA_DIR/bin/luarocks

$LUAROCKS install luasocket
$LUAROCKS install luaposix
$LUAROCKS install luafilesystem
