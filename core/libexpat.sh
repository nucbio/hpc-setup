#!/bin/bash

echo "Install libexpat"

pkg_install -n "libexpat" \
            -v "2.7.4" \
            -u "https://github.com/libexpat/libexpat/releases/download/R_2_7_4/expat-2.7.4.tar.xz"
