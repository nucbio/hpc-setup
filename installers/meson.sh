#!/bin/bash

# Meson
# https://github.com/mesonbuild/meson/releases/
# Normally meson is installed via pip3 into environment.
# Here is a bit quirky way to make a launcher in bin to set it in modules
# To launch need python3 >3.7 
LIB_DIR=$INSTALL_DIR/meson/meson-1.10.1
SRC_DIR=${LIB_DIR}/src

mkdir -p $SRC_DIR
cd $LIB_DIR
wget https://github.com/mesonbuild/meson/releases/download/1.10.1/meson-1.10.1.tar.gz
tar -xzf meson-1.10.1.tar.gz -C $SRC_DIR --strip-components=1
# install
cd $SRC_DIR
python3 setup.py install --prefix $LIB_DIR --optimize=1

make_lua_module meson 1.10.1 "$INSTALL_DIR/meson/meson-1.10.1/local/bin"
