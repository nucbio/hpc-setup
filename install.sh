#!/bin/bash

set -e

{

# Check essential components
source $REPO_DIR/install/check_essential.sh

# Set locations
mkdir -p $INSTALL_DIR/sources
export SOURCES_DIR=$INSTALL_DIR/sources 
mkdir -p $INSTALL_DIR/modulefiles
export MODULEFILES=$INSTALL_DIR/modulefiles
# Choose build directory
source $REPO_DIR/install/make_lua_module.sh
source $REPO_DIR/core/gum.sh
source $REPO_DIR/install/choose_build.sh
source $REPO_DIR/install/set_pkg_dirs.sh
# Lua
source ${REPO_DIR}/install/make_lua_module.sh

# Modules
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
# # Install R
# source $REPO_DIR/R/R.sh
#
# #module load R/$R_VERSION
# Rscript $REPO_DIR/R/R_libraries.R 
#
# # Install htslib
# source $REPO_DIR/tools/core/htslib.sh
#
# # Install bioinformatic tools
# module load htslib/$HTSLIB_VERSION
#
# for install_tool in ${REPO_DIR}/tools/illumina/*.sh
#   do 
#     source $install_tool
#   done
#
# for install_tool in ${REPO_DIR}/tools/nanopore/*.sh
#   do 
#     source $install_tool
#   done
#
# # Install CLI tools
# module load rust/$RUST_VERSION
# for install_tool in ${REPO_DIR}/tools/terminal/*.sh
#   do 
#     source $install_tool
#   done

}  2>&1 | tee -a "$INSTALL_DIR/install.log"
