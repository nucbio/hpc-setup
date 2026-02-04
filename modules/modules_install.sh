#!/bin/bash

LMOD_VERSION=9.0.5
cd /tmp
if [ -d "Lmod-${LMOD_VERSION}" ]; then
  rm -rf "Lmod-${LMOD_VERSION}"
fi
wget https://github.com/TACC/Lmod/archive/refs/tags/${LMOD_VERSION}.tar.gz -O lmod-${LMOD_VERSION}.tar.gz
tar -xzf lmod-${LMOD_VERSION}.tar.gz
cd lmod-${LMOD_VERSION}

LMOD_INSTALL=$INSTALL_DIR/lmod
mkdir -p $LMOD_INSTALL

#  FIX: Set up Lua paths
eval "$($LUA_DIR/bin/luarocks path)"

# Set up Tcl paths (fixes tcl.h detection)
export TCL_INCLUDE="-I${TCL_INSTALL}/include"
export TCL_LIBS="-L${TCL_INSTALL}/lib -ltcl8.6"

# Now configure will succeed
PATH="$LUA_DIR/bin:$PATH" ./configure \
    --prefix=$LMOD_INSTALL \
    --with-lua=$LUA_DIR/bin/lua \
    --with-luac=$LUA_DIR/bin/luac \
    --with-tcl=yes \
    --with-tclConfig=$TCL_INSTALL/lib/tclConfig.sh \
    --with-module-root-path=$INSTALL_DIR/modulefiles \
    --with-updateSystemFn=no

make install
# remove symlink
rm $LMOD_INSTALL/lmod

# Source Lmod
source "$LMOD_INSTALL/lmod-$LMOD_VERSION/init/bash"

# Optional: Add to your shell profile for persistence
# echo "source $LMOD_INSTALL/lmod/${LMOD_VERSION}/init/bash" >> ~/.bashrc
# use for tests: unset -f module
