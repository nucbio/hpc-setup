#!/bin/bash
LMOD_VERSION=9.0.5
LUA_VERSION=5.1.5
LUAROCKS_VERSION=3.12.2

# Install Lua from official source
cd /tmp
if [ -d "lua-${LUA_VERSION}" ]; then
  rm -rf "lua-${LUA_VERSION}"
fi
wget https://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz
tar -xzf lua-${LUA_VERSION}.tar.gz
cd lua-${LUA_VERSION}

LUA_INSTALL=$INSTALL_DIR/lua/lua-${LUA_VERSION}
mkdir -p $LUA_INSTALL
make linux INSTALL_TOP=$LUA_INSTALL
make install INSTALL_TOP=$LUA_INSTALL

# Install LuaRocks
cd /tmp
if [ -d "luarocks-${LUAROCKS_VERSION}" ]; then
  rm -rf "luarocks-${LUAROCKS_VERSION}"
fi
wget https://github.com/luarocks/luarocks/archive/refs/tags/v${LUAROCKS_VERSION}.tar.gz -O luarocks-${LUAROCKS_VERSION}.tar.gz
tar -xzf luarocks-${LUAROCKS_VERSION}.tar.gz
cd luarocks-${LUAROCKS_VERSION}

LUAROCKS_INSTALL=$INSTALL_DIR/luarocks/luarocks-${LUAROCKS_VERSION}
mkdir -p $LUAROCKS_INSTALL
./configure --prefix=$LUAROCKS_INSTALL --with-lua=$LUA_INSTALL
make
make install

# Install required Lua modules for Lmod
export PATH=$LUAROCKS_INSTALL/bin:$LUA_INSTALL/bin:$PATH
$LUAROCKS_INSTALL/bin/luarocks install luaposix
$LUAROCKS_INSTALL/bin/luarocks install luafilesystem

# Install Lmod
cd /tmp
if [ -d "Lmod-${LMOD_VERSION}" ]; then
  rm -rf "Lmod-${LMOD_VERSION}"
fi
wget https://github.com/TACC/Lmod/archive/refs/tags/${LMOD_VERSION}.tar.gz -O Lmod-${LMOD_VERSION}.tar.gz
tar -xzf Lmod-${LMOD_VERSION}.tar.gz
cd Lmod-${LMOD_VERSION}

LMOD_INSTALL=$INSTALL_DIR/lmod/lmod-${LMOD_VERSION}
mkdir -p $LMOD_INSTALL

./configure \
    --prefix=$LMOD_INSTALL \
    --with-lua=$LUA_INSTALL/bin/lua \
    --with-luac=$LUA_INSTALL/bin/luac

make install

# Source Lmod
source "$LMOD_INSTALL/lmod/${LMOD_VERSION}/init/bash"

# Optional: Add to your shell profile for persistence
# echo "source $LMOD_INSTALL/lmod/${LMOD_VERSION}/init/bash" >> ~/.bashrc

# use for tests: unset -f module
