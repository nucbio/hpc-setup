#!/bin/bash

echo "Install libvips"

# FIX: distutils is needed but depricated 
export SETUPTOOLS_USE_DISTUTILS=local

pkg_install -n "libvips" \
            -v "8.18.0" \
            -u "https://github.com/libvips/libvips/releases/download/v8.18.0/vips-8.18.0.tar.xz" \
            -t "meson" \
            -o "--buildtype=release \
-Dintrospection=disabled \
-Dmatio=disabled \
-Dcfitsio=disabled \
-Dpdfium=disabled \
-Dmagick=disabled"

