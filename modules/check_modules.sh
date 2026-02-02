#!/bin/bash

if command -v module &> /dev/null || type module &> /dev/null; then
    echo "✓ Environment Modules is already installed"
    echo $(module --version)
else
    # Module command not found - need to install
    echo "✗ Environment Modules not found"
    source "$REPO_DIR/modules/lua.sh"
    source "$REPO_DIR/modules/luarock.sh"
    source "$REPO_DIR/modules/tcl.sh"
    source "$REPO_DIR/modules/modules_install.sh"
fi

