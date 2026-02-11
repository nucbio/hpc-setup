#!/bin/bash

echo "Install gettext"

export GETTEXT_VERSION="1.0"

pkg_install -n "gettext" \
            -v "$GETTEXT_VERSION" \
            -u "https://ftp.gnu.org/pub/gnu/gettext/gettext-1.0.tar.gz"
