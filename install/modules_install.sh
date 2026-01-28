#!/bin/bash

TCL_VERSION=8.6.13
MODULE_VERSION=5.6.1
# TRY IF WORKS TO LOAD THE LAST and make directory with version
MODULES_VERSION=$(get_latest_github_release "cea-hpc/modules")

# Install Tcl dependency
cd /tmp
wget https://prdownloads.sourceforge.net/tcl/tcl${TCL_VERSION}-src.tar.gz
tar -xzf tcl${TCL_VERSION}-src.tar.gz
cd tcl${TCL_VERSION}/unix

# Configure and Install Tcl locally
./configure --prefix=$INSTALL_DIR
make -j$(nproc)
make install

# Install modules
cd /tmp
wget https://github.com/cea-hpc/modules/releases/download/v${MODULE_VERSION}/modules-${MODULE_VERSION}.tar.gz
tar xzf modules-${MODULE_VERSION}.tar.gz
cd modules-${MODULE_VERSION}
./configure --prefix=$INSTALL_DIR
make -j$(nproc)
make install

