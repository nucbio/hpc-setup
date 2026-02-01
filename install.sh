#!/bin/bash

set -e

source ${REPO_DIR}/install/helpers.sh
# Check if modules are installed
source ${REPO_DIR}/install/check_modules.sh

# Install installers first
for install_app in ${REPO_DIR}/installers/*.sh
  do 
    source $install_app
  done

# Install R_stack (dependencies)
# loop from r_stack

# Install tools: R and other bioinformatic tools

# Install R libraries
