#!/bin/bash

echo "Install xz"

pkg_install -n "xz" \
            -v "5.8.2" \
            -u "https://github.com/tukaani-project/xz/releases/download/v5.8.2/xz-5.8.2.tar.xz"
