#!/bin/bash

echo "Install sqlite"

pkg_install -n "sqlite" \
            -v "3.51" \
            -u "https://www.sqlite.org/2026/sqlite-autoconf-3510200.tar.gz"
