#!/bin/bash

echo "Install glib"

module load pkgconf
module load zlib
module load pcre2
module load libffi
module load gettext

GLIB_VERSION=$(pkg_version "glib")
export GLIB_VERSION

pkg_install -n "glib" \
            -t "meson"
