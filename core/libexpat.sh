#!/bin/bash

echo "Install libexpat"

export LIBEXPAT_VERSION="2.7.4"

pkg_install -n "libexpat" \
            -v "$LIBEXPAT_VERSION" \
            -u "https://github.com/libexpat/libexpat/releases/download/R_2_7_4/expat-2.7.4.tar.xz"
