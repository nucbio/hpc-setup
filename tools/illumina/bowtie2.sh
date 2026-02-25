#!/bin/bash

echo "Install Bowtie2"

PKG_VERSION="2.5.4"

pkg_install -n "bowtie2" \
            -v "$PKG_VERSION" \
            -u "https://github.com/BenLangmead/bowtie2/releases/download/v${PKG_VERSION}/bowtie2-${PKG_VERSION}-linux-x86_64.zip" \
            -t "unpack"
