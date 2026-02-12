#!/bin/bash

echo "Install libtiff"

export LIBTIFF_VERSION="4.7.1"

pkg_install \
    -n "libtiff" \
    -v "$LIBTIFF_VERSION" \
    -u "http://download.osgeo.org/libtiff/tiff-4.7.1.tar.xz"
