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

export PYTHON_VERSION="3.14.3"

pkg_install -n "python" \
            -v "$PYTHON_VERSION" \
            -u "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz" \
            -o "--enable-optimizations --with-ensurepip=install --enable-shared"
