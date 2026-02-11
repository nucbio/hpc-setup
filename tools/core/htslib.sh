#!/bin/bash

export HTSLIB_VERSION="1.23"

pkg_install \
    -n "htslib" \
    -v "$HTSLIB_VERSION" \
    -u "https://github.com/samtools/htslib/releases/download/${HTSLIB_VERSION}/htslib-${HTSLIB_VERSION}.tar.bz2" \
    -o "--enable-libcurl --enable-plugins"

