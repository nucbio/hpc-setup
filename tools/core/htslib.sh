#!/bin/bash

echo "Install htslib"

HTSLIB_VERSION=$(pkg_version "htslib")
export HTSLIB_VERSION

pkg_install \
    -n "htslib" \
    -o "--enable-libcurl --enable-plugins"

