#!/bin/bash

# Variables
export CUTADAPT_VERSION="5.0"

# Load Python
module use $INSTALL_DIR/modulefiles
module load python/$PYTHON_VERSION

python3 -m pip install cutadapt==$CUTADAPT_VERSION

# Modules
make_pip_module "cutadapt" "$CUTADAPT_VERSION"
