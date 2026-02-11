#!/bin/bash

echo "Install cairo"

export CAIRO_VERSION="1.18.4"

pkg_install -n "cairo" \
            -v "$CAIRO_VERSION" \
            -u "https://cairographics.org/releases/cairo-1.18.4.tar.xz" \
            -t "meson" \
            -o "--buildtype=release -Dtests=disabled"
