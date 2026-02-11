#!/bin/bash

echo "Install libff"

export LIBFF_VERSION="3.5.2"
pkg_install -n "libff" \
            -v "$LIBFF_VERSION" \
            -u "https://github.com/libffi/libffi/releases/download/v$LIBFF_VERSION/libffi-$LIBFF_VERSION.tar.gz" \
            -o "--disable-static --enable-shared"
