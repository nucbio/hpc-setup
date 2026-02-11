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

# Options (lets try without)
# --with-openssl="$INSTALL_DIR/openssl/openssl-$OPENSSL_VERSION" \

pkg_install -n "python" \
            -v "3.12.2" \
            -u "https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tgz" \
            -o "--enable-optimizations --with-ensurepip=install"
