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
TCL_INSTALL=$INSTALL_DIR/tcl/tcl-$TCL_VERSION
mkdir -p $TCL_INSTALL
./configure --prefix=$TCL_INSTALL
make -j$(nproc)
make install

# Install modules
cd /tmp
wget https://github.com/cea-hpc/modules/releases/download/v${MODULES_VERSION}/modules-${MODULES_VERSION}.tar.gz
tar xzf modules-${MODULES_VERSION}.tar.gz
cd modules-${MODULES_VERSION}
MODULES_INSTALL=$INSTALL_DIR/modules/modules-$MODULES_VERSION
mkdir -p $MODULES_INSTALL
#./configure --prefix=$INSTALL_DIR/modules/modules-$MODULES_VERSION
./configure \
    --prefix=$MODULES_INSTALL \
    --with-tcl=$TCL_INSTALL/lib \
    --with-tclsh=$TCL_INSTALL/bin/tclsh8.6 \
    TCLSH=$TCL_INSTALL/bin/tclsh8.6
make -j$(nproc)
make install

