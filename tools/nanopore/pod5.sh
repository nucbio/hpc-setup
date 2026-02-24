#!/bin/bash

# Variables
TOOL_NAME="pod5"
export POD5_VERSION="0.3.35"

# Load Python
module use $INSTALL_DIR/modulefiles
module load python/$PYTHON_VERSION

echo "Using Python: $(which python3)"
python3 --version

python3 -m pip install pod5==$POD5_VERSION

# Modules
make_pip_module "pod5" "$POD5_VERSION"
