#!/bin/bash

# https://gitlab.com/bzip2/bzip2/
BZIP_VERSION="1.0.8"

# Create directories
mkdir -p "$INSTALL_DIR/bzip2"
cd "$INSTALL_DIR/bzip2"

wget https://gitlab.com/bzip2/bzip2/-/archive/bzip2-$BZIP_VERSION/bzip2-bzip2-$BZIP_VERSION.tar.gz \
     -O bzip2-master.tar.gz

tar -xzf bzip2-master.tar.gz
mv bzip2-bzip2-$BZIP_VERSION bzip2-$BZIP_VERSION

# Module file
make_lua_module bzip2 $BZIP_VERSION
