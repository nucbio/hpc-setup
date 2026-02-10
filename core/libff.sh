#!/bin/bash

pkg_install -n "libff" \
            -v "3.5.2" \
            -u "https://github.com/libffi/libffi/releases/download/v3.5.2/libffi-3.5.2.tar.gz" \
            -o "--disable-static --enable-shared"
