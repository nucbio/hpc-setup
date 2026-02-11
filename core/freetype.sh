#!/bin/bash

echo "Install freetype"

# Load modules
module use $INSTALL_DIR/modulefiles
module load zlib
module load bzip2
module load libpng

# Standard meson installation
pkg_install -n "freetype" \
            -v "2.14.1" \
            -u "https://download.savannah.gnu.org/releases/freetype/freetype-2.14.1.tar.gz" \
            -t "meson" \
            -o "--buildtype=release -Ddefault_library=both"
