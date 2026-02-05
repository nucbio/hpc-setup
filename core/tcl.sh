#!/bin/bash

TCL_VERSION=8.6.13

# Install Tcl dependency
cd /tmp
if [ -d "tcl${TCL_VERSION}" ]; then
  rm -rf "tcl${TCL_VERSION}"
fi

wget https://prdownloads.sourceforge.net/tcl/tcl${TCL_VERSION}-src.tar.gz
tar -xzf tcl${TCL_VERSION}-src.tar.gz
cd tcl${TCL_VERSION}/unix

# Configure and Install Tcl locally
TCL_INSTALL=$INSTALL_DIR/tcl/tcl-$TCL_VERSION
mkdir -p $TCL_INSTALL
./configure --prefix=$TCL_INSTALL
make -j$(nproc)
make install
