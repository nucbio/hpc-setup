#!/bin/bash

module use $INSTALL_DIR/modulefiles
module load python/$PYTHON_VERSION

# Verify Python is loaded
if ! command -v python3 &> /dev/null; then
    echo "Error: Python3 not found after loading module"
    exit 1
fi

echo "Using Python: $(which python3)"
echo "Python version: $(python3 --version)"

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

echo ""
echo "=== Verification ==="
python3 -m pip --version
meson --version
ninja --version
python3 -c "import numpy; print(f'NumPy: {numpy.__version__}')"
python3 -c "import scipy; print(f'SciPy: {scipy.__version__}')"
python3 -c "import matplotlib; print(f'Matplotlib: {matplotlib.__version__}')"
python3 -c "import pandas; print(f'Pandas: {pandas.__version__}')"

echo ""
echo "Python packages installed successfully!"
