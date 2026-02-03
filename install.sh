#!/bin/bash

set -e

source ${REPO_DIR}/install/helpers.sh
# Check if modules are installed
mkdir -p $INSTALL_DIR/sources
mkdir -p $INSTALL_DIR/modulefiles

source ${REPO_DIR}/modules/check_modules.sh

# Install installers first
for install_tool in ${REPO_DIR}/installers/*.sh
  do 
    source $install_tool
  done

# Install R_stack (dependencies)
# loop from r_stack
for install_tool in ${REPO_DIR}/r_stack/*.sh
  do 
    source $install_tool
  done

source ${REPO_DIR}/tools/R/R.sh

# Install bioinformatic tools
for install_tool in ${REPO_DIR}/tools/illumina/*.sh
  do 
    source $install_tool
  done

# Install R libraries
