#!/bin/bash

# # Variables
# PKG_NAME="gatk"
# PKG_VERSION="4.6.2.0"
# PKG_URL="https://github.com/broadinstitute/gatk/releases/download/${PKG_VERSION}/gatk-${PKG_VERSION}.zip"
# PKG_ARCHIVE="$SOURCES/${PKG_NAME}-${PKG_VERSION}.zip"
#
# # Set PKG_SRC_DIR, PKG_PREFIX
# set_pkg_dirs  $PKG_NAME $PKG_VERSION
#
# wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
# unzip -q "$PKG_ARCHIVE" -d "$PKG_PREFIX"
#
# # Modules lua file
# make_lua_module "$PKG_NAME" "$PKG_VERSION" "$PKG_PREFIX/gatk-$PKG_VERSION"

echo "Install GATK"

PKG_VERSION="4.6.2.0"

pkg_install -n "gatk" \
            -v "$PKG_VERSION" \
            -u "https://github.com/broadinstitute/gatk/releases/download/$PKG_VERSION/gatk-$PKG_VERSION.zip" \
            -t "unpack"
