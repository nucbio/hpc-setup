#!/bin/bash

echo "Install POD5"

module load python/$PYTHON_VERSION
# h5py has no cp315 wheel and builds from source with HDF5_DIR
module load hdf5

pkg_install \
  -n "pod5" \
  -t "venv"

# PKG_NAME="pod5"
# PKG_VERSION="0.3.35"
# PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION"
# mkdir -p "$PKG_PREFIX"
#
# python3 -m venv "$PKG_PREFIX"
#
# "$PKG_PREFIX/bin/python3" -m pip install --upgrade pip
# "$PKG_PREFIX/bin/python3" -m pip install "${PKG_NAME}==${PKG_VERSION}"
#
# make_lua_module $PKG_NAME $PKG_VERSION
