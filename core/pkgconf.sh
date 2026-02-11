#!/bin/bash

echo "Install pkgconf"

export PKGCONF_VERSION="2.5.1"

pkg_install -n "pkgconf" \
            -v "$PKGCONF_VERSION" \
            -u "https://distfiles.dereferenced.org/pkgconf/pkgconf-$PKGCONF_VERSION.tar.xz"

# Pkg-config link
PKG_BIN=$INSTALL_DIR/pkgconf/pkgconf-$PKGCONF_VERSION/bin
ln -sf $PKG_BIN/pkgconf $PKG_BIN/pkg-config
