#!/bin/bash

echo "Install sqlite"

export SQLITE_VERSION="3.51"
pkg_install -n "sqlite" \
            -v "$SQLITE_VERSION" \
            -u "https://www.sqlite.org/2026/sqlite-autoconf-3510200.tar.gz"
