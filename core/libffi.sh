#!/bin/bash

echo "Install libffi"

export LIBFFI_VERSION="3.5.2"

pkg_install -n "libffi" \
            -v "$LIBFFI_VERSION" \
            -u "https://github.com/libffi/libffi/releases/download/v$LIBFFI_VERSION/libffi-$LIBFFI_VERSION.tar.gz" \
            -o "--disable-static --enable-shared"
