#!/bin/bash

echo "Install glib"

module load pkgconf
module load zlib
module load pcre2
module load libff
module load gettext

export GLIB_VERSION="2.87.2"

pkg_install -n "glib" \
            -v "$GLIB_VERSION" \
            -u "https://download.gnome.org/sources/glib/2.87/glib-2.87.2.tar.xz" \
            -t "meson"
