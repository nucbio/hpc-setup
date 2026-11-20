#!/bin/bash

echo "Install libffi"

LIBFFI_VERSION=$(pkg_version "libffi")
export LIBFFI_VERSION

pkg_install -n "libffi" \
            -o "--disable-static --enable-shared"
