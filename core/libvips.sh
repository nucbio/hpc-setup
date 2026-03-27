#!/bin/bash

echo "Install libvips"

# FIX: distutils is needed but depricated 
export SETUPTOOLS_USE_DISTUTILS=local

export LIBVIPS_VERSION="8.18.1"

pkg_install -n "libvips" \
            -v "$LIBVIPS_VERSION" \
            -u "https://github.com/libvips/libvips/releases/download/v8.18.1/vips-8.18.1.tar.xz" \
            -t "meson" \
            -o "--buildtype=release \
-Dintrospection=disabled \
-Dmatio=disabled \
-Dcfitsio=disabled \
-Dpdfium=disabled \
-Dmagick=disabled"

