#!/bin/bash

if command -v module &> /dev/null || type module &> /dev/null; then
    echo "✓ Environment Modules is already installed"
    echo $(module --version)
else
    # Module command not found - need to install
    echo "✗ Environment Modules not found"
    source "$REPO_DIR/install/modules_install.sh"
    # Local modules
    source "$INSTALL_DIR/modules/modules-5.6.1/init/bash"
fi

