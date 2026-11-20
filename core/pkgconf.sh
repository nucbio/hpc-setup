#!/bin/bash

echo "Install pkgconf"

PKGCONF_VERSION=$(pkg_version "pkgconf")
export PKGCONF_VERSION
PKGCONF_PREFIX=$INSTALL_DIR/pkgconf/pkgconf-$PKGCONF_VERSION

# Search path: own prefix only. The system .pc dirs are NOT built in: there
# they shadow anything our modules don't provide. Example: Ubuntu's
# python3-numpy-dev ships /usr/lib/x86_64-linux-gnu/pkgconfig/numpy.pc (numpy
# 2.3.5); meson asks pkg-config first, so pip source builds (numcodecs for
# MACS3) compiled against the system numpy headers and failed.
# PKGCONF_SYS_PC (Debian multiarch and RHEL lib64; missing dirs are ignored) is
# exported for steps that need .pc files of system libs our builds pick up
# (libcurl -> libidn2/zstd/brotli/nghttp2, libtiff -> libdeflate/Lerc,
# libxml-2.0). install.sh appends it to PKG_CONFIG_PATH for the R libraries
# only (arrow).
# system-libdir/includedir: drop -L/-I for system dirs from the output, so
# they do not end up before our own lib/include paths.
export PKGCONF_SYS_PC="/usr/lib64/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig"
PKGCONF_OPTS=(
    "--with-pkg-config-dir=$PKGCONF_PREFIX/lib/pkgconfig:$PKGCONF_PREFIX/share/pkgconfig"
    "--with-system-libdir=/usr/lib64:/usr/lib/x86_64-linux-gnu:/usr/lib:/lib64:/lib"
    "--with-system-includedir=/usr/include"
)

pkg_install -n "pkgconf" -o "${PKGCONF_OPTS[*]}"

# Pkg-config link
PKG_BIN=$PKGCONF_PREFIX/bin
ln -sf $PKG_BIN/pkgconf $PKG_BIN/pkg-config
