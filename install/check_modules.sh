#!/bin/bash

if command -v module &> /dev/null || type module &> /dev/null; then
    echo "✓ Environment Modules is already installed"
    echo $(module --version)
else
    # Module command not found - need to install
    echo "✗ Environment Modules not found"
    source $REPO_DIR/install/modules_install.sh 
fi

echo "SUCCESS UP TO THE LABLE!!!"


/home/suvar/install_test/hpc-setup-main/install/check_modules.sh: line 9: /install/modules_install.sh: No such file or directory
