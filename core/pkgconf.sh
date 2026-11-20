#!/bin/bash

echo "Install pkgconf"

PKGCONF_VERSION=$(pkg_version "pkgconf")
export PKGCONF_VERSION
PKGCONF_PREFIX=$INSTALL_DIR/pkgconf/pkgconf-$PKGCONF_VERSION

# Search path: own prefix first, then the system dirs (Debian multiarch and
# RHEL lib64; missing dirs are ignored). Without the system dirs, .pc files of
# system libs that our builds pick up (libcurl -> libidn2/zstd/brotli/nghttp2,
# libtiff -> libdeflate/Lerc, libxml-2.0) are not found and pkg-config fails.
# Module PKG_CONFIG_PATH entries are searched before these.
# system-libdir/includedir: drop -L/-I for system dirs from the output, so
# they do not end up before our own lib/include paths.
PKGCONF_SYS_PC="/usr/lib64/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig"
PKGCONF_OPTS=(
    "--with-pkg-config-dir=$PKGCONF_PREFIX/lib/pkgconfig:$PKGCONF_PREFIX/share/pkgconfig:$PKGCONF_SYS_PC"
    "--with-system-libdir=/usr/lib64:/usr/lib/x86_64-linux-gnu:/usr/lib:/lib64:/lib"
    "--with-system-includedir=/usr/include"
)

pkg_install -n "pkgconf" -o "${PKGCONF_OPTS[*]}"

# Pkg-config link
PKG_BIN=$PKGCONF_PREFIX/bin
ln -sf $PKG_BIN/pkgconf $PKG_BIN/pkg-config
