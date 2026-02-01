#!/bin/bash

if command -v module &> /dev/null || type module &> /dev/null; then
    echo "✓ Environment Modules is already installed"
    echo $(module --version)
else
    # Module command not found - need to install
    echo "✗ Environment Modules not found"
    source "$REPO_DIR/install/modules_install.sh"

    # Make local modules available
    MODULE_ROOT="/home/suvar/test_install/modules-5.6.1"
    if [ -f "$MODULE_ROOT/init/bash" ]; then
        source "$MODULE_ROOT/init/bash"
        echo "✓ Local 'module' function defined from $MODULE_ROOT"
    else
        echo "✗ Error: Could not find init script in $MODULE_ROOT/init/bash"
        exit 1
    fi
fi

