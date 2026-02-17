#!/bin/bash

echo "Install zlib"
echo "FLAG2"
export ZLIB_VERSION="1.3.1"
echo "FLAG3"
pkg_install -n "zlib" \
            -v "$ZLIB_VERSION" \
            -u "https://zlib.net/zlib-$ZLIB_VERSION.tar.gz"

