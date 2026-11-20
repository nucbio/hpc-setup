#!/bin/bash

echo "Install freetype"

# Load modules
module use $INSTALL_DIR/modulefiles
module load zlib
module load bzip2
module load libpng

FREETYPE_VERSION=$(pkg_version "freetype2")
export FREETYPE_VERSION

pkg_install -n "freetype2" \
            -t "meson" \
            -o "--buildtype=release -Ddefault_library=both"
