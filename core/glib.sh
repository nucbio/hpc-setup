#!/bin/bash

module load pkgconf
module load zlib
module load pcre2
module load libff
module load gettext

pkg_install -n "glib" \
            -v "2.87.2" \
            -u "https://download.gnome.org/sources/glib/2.87/glib-2.87.2.tar.xz" \
            -t "meson"
