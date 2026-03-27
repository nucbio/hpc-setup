#!/bin/bash

echo "Install glib"

module load pkgconf
module load zlib
module load pcre2
module load libffi
module load gettext

export GLIB_VERSION="2.88.0"

pkg_install -n "glib" \
            -v "$GLIB_VERSION" \
            -u "https://download.gnome.org/sources/glib/2.88/glib-2.88.0.tar.xz" \
            -t "meson"
