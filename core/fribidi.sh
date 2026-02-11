#!/bin/bash

echo "Install fribidi"

export FRIBIDI_VERSION="1.0.16"

pkg_install -n "fribidi" \
            -v "$FRIBIDI_VERSION" \
            -u "https://github.com/fribidi/fribidi/releases/download/v1.0.16/fribidi-1.0.16.tar.xz"
