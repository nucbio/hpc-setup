#!/bin/bash

# 9.5: first Lmod with the new luaposix interface (needed for Lua 5.5)
LMOD_VERSION=9.5

# Each step skips itself when it is already installed (stamps / Lmod init file)
source "$REPO_DIR/lua/lua.sh"
source "$REPO_DIR/lua/luarock.sh"
source "$REPO_DIR/core/tcl.sh"

# Always our own Lmod in $INSTALL_DIR, even if the system (HPC) already provides a
# `module` command (it survives "module --force purge"). modules_install.sh skips the
# build if $INSTALL_DIR/lmod/$LMOD_VERSION exists and works, and loads it instead.
source "$REPO_DIR/modules/modules_install.sh"

# Newly written modulefiles must be visible at once: a user spider cache
export LMOD_IGNORE_CACHE=1
# Unversioned "module load X" takes X from the first MODULEPATH entry
# ($INSTALL_DIR/modulefiles, prepended by "module use") instead of the highest
# version of a system module (e.g. a sticky HPC release module survives "module purge").
export LMOD_TMOD_FIND_FIRST=yes
