#!/bin/bash

echo "Install pkgconf"

PKGCONF_VERSION=$(pkg_version "pkgconf")
export PKGCONF_VERSION

pkg_install -n "pkgconf"

# Pkg-config link
PKG_BIN=$INSTALL_DIR/pkgconf/pkgconf-$PKGCONF_VERSION/bin
ln -sf $PKG_BIN/pkgconf $PKG_BIN/pkg-config
