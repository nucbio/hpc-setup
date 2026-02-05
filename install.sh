#!/bin/bash

set -e

{

# Get Functions
source $REPO_DIR/install/helpers.sh
source ${REPO_DIR}/install/make_lua_module.sh

# Set locations
mkdir -p $INSTALL_DIR/sources
mkdir -p $INSTALL_DIR/modulefiles

# Check if modules are installed
source ${REPO_DIR}/modules/check_modules.sh

# Install core dependencies
source $REPO_DIR/install/core_install.sh

# Install python
source $REPO_DIR/python/python_install.sh
source $REPO_DIR/python/python_packages.sh

# Java
source $REPO_DIR/java/jdk.sh
# Rust
source $REPO_DIR/rust/rust.sh

# Meson/Ninja dependent packages
source $REPO_DIR/install/core_install_py.sh
# Install R
source $REPO_DIR/R/R.sh

module R/$R_VERSION
Rscript $REPO_DIR/R/R_libraries.R 

# Install bioinformatic tools
for install_tool in ${REPO_DIR}/tools/illumina/*.sh
  do 
    source $install_tool
  done

# Install CLI tools
module load rust/$RUST_VERSION
for install_tool in ${REPO_DIR}/tools/terminal/*.sh
  do 
    source $install_tool
  done

}  2>&1 | tee -a "$INSTALL_DIR/install.log"
