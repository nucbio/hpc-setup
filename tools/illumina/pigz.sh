#!/bin/bash

echo "Installing Pigz"

PKG_NAME="pigz"
PKG_VERSION=$(pkg_version "$PKG_NAME")
PKG_URL=$(pkg_url "$PKG_NAME")
PKG_ARCHIVE="$SOURCES_DIR/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION"

# Already installed by a previous run? (see functions/stamp.sh)
if skip_if_installed "$PKG_NAME" "$PKG_VERSION"; then
  return 0
fi

mkdir -p $PKG_PREFIX

wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_PREFIX" --strip-components=1

cd "$PKG_PREFIX"
make -j $(nproc)

# Modules lua file
module_templater "$PKG_NAME"
