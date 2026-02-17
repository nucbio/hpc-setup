#!/bin/bash

echo "Install zlib"

export ZLIB_VERSION="1.3.2"

pkg_install -n "zlib" \
            -v "$ZLIB_VERSION" \
            -u "https://zlib.net/zlib-$ZLIB_VERSION.tar.xz"

