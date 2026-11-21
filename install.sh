#!/bin/bash

set -e
# Exit status of the { ... } | tee pipeline below is the install's, not tee's
set -o pipefail

{

# Source functions
for func in $REPO_DIR/functions/*.sh
  do 
    source $func
  done

# Check essential components
source $REPO_DIR/install/check_essential.sh

# Set locations
mkdir -p $INSTALL_DIR/sources
export SOURCES_DIR=$INSTALL_DIR/sources 
mkdir -p $INSTALL_DIR/modulefiles
export MODULEFILES=$INSTALL_DIR/modulefiles

# jq first: versions are read from pkgs.json with it
source $REPO_DIR/core/jq.sh

# Choose build directory
source $REPO_DIR/core/gum.sh
source $REPO_DIR/install/choose_build.sh

# Modules
source $REPO_DIR/modules/check_modules.sh

# Install core dependencies
source $REPO_DIR/install/core_install.sh

# Install python
source $REPO_DIR/python/python_install.sh
# No stamp: pip skips packages that are already installed
source $REPO_DIR/python/python_packages.sh

# Java
source $REPO_DIR/java/java.sh
# Rust
source $REPO_DIR/rust/rust.sh

# Meson/Ninja dependent packages
source $REPO_DIR/install/core_install_py.sh

# Install R
source $REPO_DIR/R/R.sh

# R libraries: no stamp, R_libraries.R installs only missing packages
# and fails if a package could not be installed
module load R
# System .pc dirs for this step only (arrow needs .pc files of system libs, see
# core/pkgconf.sh). Not exported: later pip/meson builds must not see them.
PKG_CONFIG_PATH="${PKG_CONFIG_PATH:+$PKG_CONFIG_PATH:}$PKGCONF_SYS_PC" \
  Rscript $REPO_DIR/R/R_libraries.R

# Install htslib
source $REPO_DIR/tools/core/htslib.sh

# Install bioinformatic tools
module load htslib/$HTSLIB_VERSION

for install_tool in $REPO_DIR/tools/illumina/*.sh
  do 
    source $install_tool
  done

# Install Nanopore tools
for install_tool in $REPO_DIR/tools/nanopore/*.sh
  do 
    source $install_tool
  done

# Install CLI tools
for install_tool in $REPO_DIR/tools/terminal/*.sh
  do 
    source $install_tool
  done

# HPC-setup release
source $REPO_DIR/modules/release_module.sh

# Run test (always: cheap verification)
source $REPO_DIR/modules/test_install.sh

echo "HPC-setup is done!"

}  2>&1 | tee -a "$INSTALL_DIR/install.log"
