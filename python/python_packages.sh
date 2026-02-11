#!/bin/bash

module use $INSTALL_DIR/modulefiles
module load python

# Verify Python is loaded
if ! command -v python3 &> /dev/null; then
    echo "Error: Python3 not found after loading module"
    exit 1
fi

echo "Upgrading pip..."
python3 -m pip install --upgrade pip

echo "Installing build tools..."
python3 -m pip install --upgrade setuptools wheel

echo "Installing build systems..."
python3 -m pip install meson ninja

echo "Installing scientific packages..."
python3 -m pip install numpy scipy matplotlib pandas

echo "Installing additional useful packages..."
python3 -m pip install \
    ipython \
    pytest \
    requests

