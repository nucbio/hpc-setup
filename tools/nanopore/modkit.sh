#!/bin/bash

echo "Install modkit"

PKG_VERSION="0.6.0"

pkg_install \
  -n "modkit" \
  -v "$PKG_VERSION" \
  -u "https://github.com/nanoporetech/modkit/releases/download/v0.6.0/modkit_v0.6.0_u16_x86_64.tar.gz" \
  -t "unpack"

# PKG_NAME="modkit"
# PKG_VERSION="0.6.0"
# PKG_URL="https://github.com/nanoporetech/modkit/releases/download/v0.6.0/modkit_v0.6.0_u16_x86_64.tar.gz"
#
# PKG_ARCHIVE="$SOURCES_DIR/$PKG_NAME-$PKG_VERSION.tar.gz"
#
# # Set PKG_SRC_DIR, PKG_PREFIX
# set_pkg_dirs  $PKG_NAME $PKG_VERSION
#
# wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
# mkdir -p "$PKG_PREFIX/bin"
# tar -xzf "$PKG_ARCHIVE" -C "$PKG_PREFIX/bin" --strip-components=1
#
# # Modules lua file
# make_lua_module "$PKG_NAME" "$PKG_VERSION" "$PKG_PREFIX/bin"
