#!/bin/bash

# # Variables
# PKG_NAME="fastqc"
# PKG_VERSION="0.12.1"
# PKG_URL="https://www.bioinformatics.babraham.ac.uk/projects/fastqc/${PKG_NAME}_v${PKG_VERSION}.zip"
# PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}_v${PKG_VERSION}.zip"
#
# # Set PKG_SRC_DIR, PKG_PREFIX
# set_pkg_dirs  $PKG_NAME $PKG_VERSION
#
# # Download to sources directory
# wget -q "$PKG_URL" -O "$PKG_ARCHIVE"
# unzip -q "$PKG_ARCHIVE" -d "$PKG_PREFIX"
#
# # Modules lua file
# make_lua_module $PKG_NAME $PKG_VERSION "$PKG_PREFIX/FastQC"

echo "Install FastQC"

PKG_VERSION="0.12.1"

pkg_install -n "fastqc" \
            -v "$PKG_VERSION" \
            -u "https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${PKG_VERSION}.zip" \
            -t "unpack"
