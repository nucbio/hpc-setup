#!/bin/bash

echo "Install fribidi"

pkg_install -n "fribidi" \
            -v "1.0.16" \
            -u "https://github.com/fribidi/fribidi/releases/download/v1.0.16/fribidi-1.0.16.tar.xz"
