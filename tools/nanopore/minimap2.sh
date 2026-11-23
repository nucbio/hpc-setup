#!/bin/bash

echo "Install minimap2"

# Prebuilt x86_64 binaries (minimap2, k8, paftools.js) in the archive's top folder.
# Not via pkg_install -t unpack: the man page minimap2.1 sits in the root and
# must be linked into share/man before module_templater runs (MANPATH detection).

PKG_NAME="minimap2"
PKG_VERSION=$(pkg_version "$PKG_NAME")
PKG_URL=$(pkg_url "$PKG_NAME")
PKG_ARCHIVE="$SOURCES_DIR/${PKG_URL##*/}"
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION"

# Already installed by a previous run? (see functions/stamp.sh)
if skip_if_installed "$PKG_NAME" "$PKG_VERSION"; then
  return 0
fi

mkdir -p "$PKG_PREFIX"

wget -nv -c --tries=10 --read-timeout=30 --waitretry=5 "$PKG_URL" -O "$PKG_ARCHIVE"
tar -xjf "$PKG_ARCHIVE" -C "$PKG_PREFIX" --strip-components=1

# Man page where MANPATH (share/man) finds it
mkdir -p "$PKG_PREFIX/share/man/man1"
ln -sf ../../../minimap2.1 "$PKG_PREFIX/share/man/man1/minimap2.1"

# Modules lua file
module_templater "$PKG_NAME"
