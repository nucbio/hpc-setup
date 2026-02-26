#!/bin/bash



echo "Install FastQC"

PKG_VERSION="0.12.1"

pkg_install -n "fastqc" \
            -v "$PKG_VERSION" \
            -u "https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${PKG_VERSION}.zip" \
            -t "unpack"
