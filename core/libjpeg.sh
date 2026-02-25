#!/bin/bash

export LIBJPEG_VERSION="3.1.2"

# Standard cmake install
pkg_install \
    -n "libjpeg" \
    -v "$LIBJPEG_VERSION" \
    -u "https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/$LIBJPEG_VERSION/libjpeg-turbo-$LIBJPEG_VERSION.tar.gz" \
    -t "cmake"

