#!/bin/bash
LMOD_VERSION=8.7.52
LUA_VERSION=5.1.4.9
LUAROCKS_VERSION=3.11.1

# Install Lua dependency
cd /tmp
if [ -d "lua-${LUA_VERSION}" ]; then
  rm -rf "lua-${LUA_VERSION}"
fi
wget https://sourceforge.net/projects/luabinaries/files/${LUA_VERSION}/Tools%20Executables/lua-${LUA_VERSION}_Linux54_64_lib.tar.gz
mkdir -p lua-${LUA_VERSION}
cd lua-${LUA_VERSION}
tar -xzf ../lua-${LUA_VERSION}_Linux54_64_lib.tar.gz

# Install Lua from source for better compatibility
cd /tmp
if [ -d "lua-5.1.5" ]; then
  rm -rf "lua-5.1.5"
fi
wget http://www.lua.org/ftp/lua-5.1.5.tar.gz
tar -xzf lua-5.1.5.tar.gz
cd lua-5.1.5

LUA_INSTALL=$INSTALL_DIR/lua/lua-5.1.5
mkdir -p $LUA_INSTALL
make linux INSTALL_TOP=$LUA_INSTALL
make install INSTALL_TOP=$LUA_INSTALL

# Install LuaRocks (optional but recommended for Lmod dependencies)
cd /tmp
if [ -d "luarocks-${LUAROCKS_VERSION}" ]; then
  rm -rf "luarocks-${LUAROCKS_VERSION}"
fi
wget https://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz
tar -xzf luarocks-${LUAROCKS_VERSION}.tar.gz
cd luarocks-${LUAROCKS_VERSION}

LUAROCKS_INSTALL=$INSTALL_DIR/luarocks/luarocks-${LUAROCKS_VERSION}
mkdir -p $LUAROCKS_INSTALL
./configure --prefix=$LUAROCKS_INSTALL --with-lua=$LUA_INSTALL
make
make install

# Install required Lua modules for Lmod
export PATH=$LUAROCKS_INSTALL/bin:$PATH
luarocks install luaposix
luarocks install luafilesystem

# Install Lmod
cd /tmp
if [ -d "Lmod-${LMOD_VERSION}" ]; then
  rm -rf "Lmod-${LMOD_VERSION}"
fi
wget https://github.com/TACC/Lmod/archive/${LMOD_VERSION}.tar.gz -O Lmod-${LMOD_VERSION}.tar.gz
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
