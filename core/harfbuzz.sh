#!/bin/bash

echo "Install harfbuzz"

export HARFBUZZ_VERSION="12.2.0"

pkg_install -n "harfbuzz" \
            -v "$HARFBUZZ_VERSION" \
            -u "https://github.com/harfbuzz/harfbuzz/releases/download/12.2.0/harfbuzz-12.2.0.tar.xz" \
            -t "meson" \
            -o "--buildtype=release \
-Dtests=disabled \
-Ddocs=disabled \
-Dintrospection=disabled"

