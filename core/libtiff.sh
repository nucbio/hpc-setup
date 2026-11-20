#!/bin/bash

echo "Install libtiff"

LIBTIFF_VERSION=$(pkg_version "libtiff")
export LIBTIFF_VERSION

pkg_install \
    -n "libtiff"
