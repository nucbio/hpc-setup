#!/bin/bash

echo "Install libvips"

# FIX: distutils is needed but depricated 
export SETUPTOOLS_USE_DISTUTILS=local

export LIBVIPS_VERSION="8.18.0"

pkg_install -n "libvips" \
            -v "$LIBVIPS_VERSION" \
            -u "https://github.com/libvips/libvips/releases/download/v$LIBVIPS_VERSION/vips-$LIBVIPS_VERSION.tar.xz" \
            -t "meson" \
            -o "--buildtype=release \
-Dintrospection=disabled \
-Dmatio=disabled \
-Dcfitsio=disabled \
-Dpdfium=disabled \
-Dmagick=disabled"

