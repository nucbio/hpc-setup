#!/bin/bash

echo "Install MACS3"

module load python/$PYTHON_VERSION
# h5py has no cp315 wheel and builds from source with HDF5_DIR
module load hdf5

pkg_install \
  -n "macs3" \
  -t "venv"
