#!/bin/bash

echo "Install harfbuzz"

HARFBUZZ_VERSION=$(pkg_version "harfbuzz")
export HARFBUZZ_VERSION

pkg_install -n "harfbuzz" \
            -t "meson" \
            -o "--buildtype=release \
-Dtests=disabled \
-Ddocs=disabled \
-Dintrospection=disabled"

