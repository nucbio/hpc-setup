#!/bin/bash

module use $INSTALL_DIR/modulefiles
module load python/$PYTHON_VERSION

pip3 install numpy scipy matplotlib pandas
