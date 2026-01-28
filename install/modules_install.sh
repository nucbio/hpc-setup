#!/bin/bash

INSTALL_DIR=$HOME/modules
VERSION=5.6.1

cd /tmp
wget https://github.com/cea-hpc/modules/releases/download/v${VERSION}/modules-${VERSION}.tar.gz
tar xzf modules-${VERSION}.tar.gz
cd modules-${VERSION}
./configure --prefix=$INSTALL_DIR
make -j$(nproc)
make install

source $INSTALL_DIR/init/bash
