#!/bin/bash

echo "Install xz"

export XZ_VERSION="5.8.2"
pkg_install -n "xz" \
            -v "$XZ_VERSION" \
            -u "https://github.com/tukaani-project/xz/releases/download/v$XZ_VERSION/xz-$XZ_VERSION.tar.xz"
