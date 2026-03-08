#!/bin/bash

echo "Install sqlite3"

export SQLITE_VERSION="3.51"
pkg_install -n "sqlite3" \
            -v "$SQLITE_VERSION" \
            -u "https://www.sqlite.org/2026/sqlite-autoconf-3510200.tar.gz"
