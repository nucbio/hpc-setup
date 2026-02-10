#!/bin/bash

echo "Install cairo"

pkg_install -n "cairo" \
            -v "1.18.4" \
            -u "https://cairographics.org/releases/cairo-${CAIRO_VERSION}.tar.xz" \
            -t "meson" \
            -o "--buildtype=release -Dtests=disabled"
