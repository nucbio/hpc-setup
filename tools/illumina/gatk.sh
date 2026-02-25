#!/bin/bash

echo "Install GATK"

PKG_VERSION="4.6.2.0"

pkg_install -n "gatk" \
            -v "$PKG_VERSION" \
            -u "https://github.com/broadinstitute/gatk/releases/download/$PKG_VERSION/gatk-$PKG_VERSION.zip" \
            -t "unpack"
