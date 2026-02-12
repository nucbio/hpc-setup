#!/bin/bash

echo "Install gperf"

export GPERF_VERSION="3.3"

pkg_install \
    -n "gperf" \
    -v "$GPERF_VERSION" \
    -u "http://ftp.gnu.org/pub/gnu/gperf/gperf-$GPERF_VERSION.tar.gz"
