#!/bin/bash

set -e

source ${REPO_DIR}/install/helpers.sh
# Check if modules are installed
source ${REPO_DIR}/install/check_modules.sh

# Modulefiles
mkdir -p $INSTALL_DIR/modulefiles
# Archive collection
mkdir - p $INSTALL_DIR/sources

# Install installers first
for install_tool in ${REPO_DIR}/installers/*.sh
  do 
    source $install_tool
  done

# Install R_stack (dependencies)
# loop from r_stack
#for install_tool in ${REPO_DIR}/r_stack/*.sh
#  do 
#    source $install_tool
#  done

# Install bioinformatic tools
for install_tool in ${REPO_DIR}/tools/illumina/*.sh
  do 
    source $install_tool
  done
# Install R libraries
