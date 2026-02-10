#!/bin/bash

pkg_install -n "pkgconf" \
            -v "2.5.1" \
            -u "https://distfiles.dereferenced.org/pkgconf/pkgconf-2.5.1.tar.xz"

# Pkg-config link
PKG_BIN=$INSTALL_DIR/pkgconf/pkgconf-2.5.1/bin
ln -sf $PKG_BIN/pkgconf $PKG_BIN/pkg-config
