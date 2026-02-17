#!/bin/bash

echo "Install python"

# Load dependencies
module use $INSTALL_DIR/modulefiles
module load openssl
module load readline
module load ncurses
module load xz
module load bzip2
module load sqlite
module load libcurl

pkg_install -n "python" \
            -v "3.14.3" \
            -u "https://www.python.org/ftp/python/3.14.3/Python-3.14.3.tar.xz" \
            -o "--enable-optimizations --with-ensurepip=install --enable-shared"
