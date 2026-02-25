#!/bin/bash

echo "Install Cutadapt"

module load python/$PYTHON_VERSION

pkg_install \
  -n "cutadapt" \
  -v "5.0" \
  -t "venv"

# PKG_NAME="cutadapt"
# PKG_VERSION="5.0"
#
# PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION"
# mkdir -p "$PKG_PREFIX"
# module load python/$PYTHON_VERSION
# python3 -m venv "$PKG_PREFIX"
#
# "$PKG_PREFIX/bin/python3" -m pip install --upgrade pip
# "$PKG_PREFIX/bin/python3" -m pip install "${PKG_NAME}==${PKG_VERSION}"
#
# make_lua_module $PKG_NAME $PKG_VERSION
