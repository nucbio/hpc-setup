#!/bin/bash

# # Variables
# export CUTADAPT_VERSION="5.0"
#
# # Load Python
# module use $INSTALL_DIR/modulefiles
# module load python/$PYTHON_VERSION
#
# python3 -m pip install cutadapt==$CUTADAPT_VERSION
#
# # Modules
# make_pip_module "cutadapt" "$CUTADAPT_VERSION"

echo "Install Cutadapt"

PKG_NAME="cutadapt"
export PKG_VERSION="5.0"

PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION"
mkdir -p "$PKG_PREFIX"
module load python/$PYTHON_VERSION
python3 -m venv "$PKG_PREFIX"

"$PKG_PREFIX/bin/python3" -m pip install --upgrade pip
"$PKG_PREFIX/bin/python3" -m pip install "${PKG_NAME}==${PKG_VERSION}"

make_lua_module $PKG_NAME $PKG_VERSION
