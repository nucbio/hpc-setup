#!/bin/bash

echo "Install freetype"

pkg_install -n "freetype" \
            -v "2.14.1" \
            -u "https://download.savannah.gnu.org/releases/freetype/freetype-2.14.1.tar.gz" \
            -t "meson" \
            -o "--buildtype=release"
