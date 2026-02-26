#!/bin/bash

echo "Install libpng"

export LIBPNG_VERSION="1.6.50"

pkg_install -n "libpng" \
            -v "$LIBPNG_VERSION" \
            -u "https://downloads.sourceforge.net/libpng/libpng-$LIBPNG_VERSION.tar.gz"
