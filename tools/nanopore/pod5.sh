#!/bin/bash

# # Variables
# TOOL_NAME="pod5"
# export POD5_VERSION="0.3.35"
#
# # Load Python
# module use $INSTALL_DIR/modulefiles
# module load python/$PYTHON_VERSION
#
# echo "Using Python: $(which python3)"
# python3 --version
#
# python3 -m pip install pod5==$POD5_VERSION

# Modules
#make_pip_module "pod5" "$POD5_VERSION"

module load python/$PYTHON_VERSION

PKG_NAME="pod5"
PKG_VERSION="0.3.35"
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION"
mkdir -p "$PKG_PREFIX"

python3 -m venv "$PKG_PREFIX"

"$PKG_PREFIX/bin/python3" -m pip install --upgrade pip
"$PKG_PREFIX/bin/python3" -m pip install "${PKG_NAME}==${PKG_VERSION}"

make_lua_module $PKG_NAME $PKG_VERSION
