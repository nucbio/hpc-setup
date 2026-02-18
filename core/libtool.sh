#!/bin/bash

export LIBTOOL_VERSION="2.5.4"

pkg_install \
    -n "libtool" \
    -v "$LIBTOOL_VERSION" \
    -u "https://ftp.gnu.org/gnu/libtool/libtool-$LIBTOOL_VERSION.tar.xz"
