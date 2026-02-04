#!/bin/bash

set -e

source ${REPO_DIR}/install/helpers.sh
source ${REPO_DIR}/install/make_lua_module.sh

# Check if modules are installed
mkdir -p $INSTALL_DIR/sources
mkdir -p $INSTALL_DIR/modulefiles

source ${REPO_DIR}/modules/check_modules.sh

# Install installers first
for install_tool in ${REPO_DIR}/installers/*.sh
  do 
    source $install_tool
  done

# Install bioinformatic tools
for install_tool in ${REPO_DIR}/tools/illumina/*.sh
  do 
    source $install_tool
  done

# Install R dependencies
source ${REPO_DIR}/R/R_stack_install.sh

# Install R
source ${REPO_DIR}/R/R_install.sh

# Install R libraries

# Install CLI tools
module load rust/$RUST_VERSION
for install_tool in ${REPO_DIR}/tools/terminal/*.sh
  do 
    source $install_tool
  done

