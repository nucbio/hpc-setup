#!/bin/bash

echo "Install freetype"

# Load modules
module use $INSTALL_DIR/modulefiles
module load zlib
module load bzip2
module load libpng

export FREETYPE_VERSION="2.14.1"

pkg_install -n "freetype2" \
            -v "$FREETYPE_VERSION" \
            -u "https://download.savannah.gnu.org/releases/freetype/freetype-2.14.1.tar.gz" \
            -t "meson" \
            -o "--buildtype=release -Ddefault_library=both"
