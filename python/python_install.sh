#!/bin/bash

echo "Install python"

# Load dependencies
module use $INSTALL_DIR/modulefiles
module load openssl
module load readline
module load ncurses
module load xz
module load bzip2
module load sqlite3
module load libcurl

PYTHON_VERSION=$(pkg_version "python")
export PYTHON_VERSION

pkg_install -n "python" \
            -o "--enable-optimizations --with-ensurepip=install --enable-shared"
