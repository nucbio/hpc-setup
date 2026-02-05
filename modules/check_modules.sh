#!/bin/bash
source "$REPO_DIR/lua/lua.sh"
source "$REPO_DIR/lua/luarock.sh"
source "$REPO_DIR/core/tcl.sh"

if command -v module &> /dev/null || type module &> /dev/null; then
    echo "✓ Environment Modules is already installed"
    echo $(module --version)
else
    # Module command not found - need to install
    echo "✗ Environment Modules not found"
    source "$REPO_DIR/modules/modules_install.sh"
fi

