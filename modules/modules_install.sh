#!/bin/bash

# Install Lmod
LMOD_VERSION=9.0.5

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
    --with-luac=$LUA_INSTALL/bin/luac \
    --with-tcl=yes \
    --with-tclConfig=$TCL_INSTALL/lib/tclConfig.sh \
    --with-module-root-path=$INSTALL_DIR/modulefiles \
    --with-updateSystemFn=no
make install

# Source Lmod
source "$LMOD_INSTALL/lmod/${LMOD_VERSION}/init/bash"

# Optional: Add to your shell profile for persistence
# echo "source $LMOD_INSTALL/lmod/${LMOD_VERSION}/init/bash" >> ~/.bashrc
# use for tests: unset -f module
