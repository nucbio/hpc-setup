#!/bin/bash

echo "Install libxml2"

export LIBXML2_VERSION="2.15.1"

# for R xml support
ZLIB="$INSTALL_DIR/zlib/zlib-$ZLIB_VERSION"

pkg_install \
    -n "libxml2" \
    -v "$LIBXML2_VERSION" \
    -u "https://download.gnome.org/sources/libxml2/2.15/libxml2-$LIBXML2_VERSION.tar.xz" \
    -o "--with-zlib=$ZLIB"

