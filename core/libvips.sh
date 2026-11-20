#!/bin/bash

echo "Install libvips"

# FIX: distutils is needed but depricated 
export SETUPTOOLS_USE_DISTUTILS=local

LIBVIPS_VERSION=$(pkg_version "libvips")
export LIBVIPS_VERSION

pkg_install -n "libvips" \
            -t "meson" \
            -o "--buildtype=release \
-Dintrospection=disabled \
-Dmatio=disabled \
-Dcfitsio=disabled \
-Dpdfium=disabled \
-Dmagick=disabled"

