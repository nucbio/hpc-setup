#!/bin/bash

TCL_VERSION=8.6.13
#MODULE_VERSION=5.6.1
# TRY IF WORKS TO LOAD THE LAST and make directory with version
MODULES_VERSION=$(get_latest_github_release "cea-hpc/modules")

# Install Tcl dependency
cd /tmp
wget https://prdownloads.sourceforge.net/tcl/tcl${TCL_VERSION}-src.tar.gz
tar -xzf tcl${TCL_VERSION}-src.tar.gz
cd tcl${TCL_VERSION}/unix

# Configure and Install Tcl locally
mkdir -p $INSTALL_DIR/tcl-$TCL_VERSION
./configure --prefix=$INSTALL_DIR/tcl-$TCL_VERSION
make -j$(nproc)
make install

# Install modules
cd /tmp
wget https://github.com/cea-hpc/modules/releases/download/v${MODULE_VERSION}/modules-${MODULE_VERSION}.tar.gz
tar xzf modules-${MODULES_VERSION}.tar.gz
cd modules-${MODULES_VERSION}
mkdir $INSTALL_DIR/modules-$MODULES_VERSION
./configure --prefix=$INSTALL_DIR/modules-$MODULES_VERSION
make -j$(nproc)
make install

