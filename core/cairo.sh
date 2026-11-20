#!/bin/bash

echo "Install cairo"

CAIRO_VERSION=$(pkg_version "cairo")
export CAIRO_VERSION

pkg_install -n "cairo" \
            -t "meson" \
            -o "--buildtype=release -Dtests=disabled"
