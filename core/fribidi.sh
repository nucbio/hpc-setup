#!/bin/bash

echo "Install fribidi"

FRIBIDI_VERSION=$(pkg_version "fribidi")
export FRIBIDI_VERSION

# meson, not autotools: the autotools build always regenerates bin/fribidi.1
# with help2man (fails if help2man is missing); meson installs the man page
# shipped in the release tarball
pkg_install -n "fribidi" \
            -t "meson" \
            -o "-Dtests=false"
