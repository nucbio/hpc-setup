#!/bin/bash

echo "Install libjpeg"

LIBJPEG_VERSION=$(pkg_version "libjpeg")
export LIBJPEG_VERSION

pkg_install \
    -n "libjpeg" \
    -t "cmake"

