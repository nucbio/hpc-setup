#!/bin/bash

echo "Install zlib"

pkg_install -n "zlib" \
            -v "1.3.1" \
            -u "https://zlib.net/zlib-1.3.1.tar.gz"

