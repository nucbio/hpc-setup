#!/bin/bash

# Variables
TOOL_NAME="pod5"
export POD5_VERSION="0.3.36"

# Load Python
module use $INSTALL_DIR/modulefiles
module load python/$PYTHON_VERSION

echo "Using Python: $(which python3)"
python3 --version

python3 -m pip install pod5==$POD5_VERSION

