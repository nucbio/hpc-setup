#!/bin/bash

echo "Install Nextflow"

# Self-contained "-dist" launcher (launcher script + fat jar in one file):
# no download into ~/.nextflow at first run, so it works on offline compute nodes.
# Single file, not an archive: not via pkg_install -t unpack.
# Needs Java >= 17: the module loads java (dependencies in pkgs.json).

PKG_NAME="nextflow"
PKG_VERSION=$(pkg_version "$PKG_NAME")
PKG_URL=$(pkg_url "$PKG_NAME")
PKG_ARCHIVE="$SOURCES_DIR/${PKG_URL##*/}"
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION"

# Already installed by a previous run? (see functions/stamp.sh)
if skip_if_installed "$PKG_NAME" "$PKG_VERSION"; then
  return 0
fi

wget -nv -c --tries=10 --read-timeout=30 --waitretry=5 "$PKG_URL" -O "$PKG_ARCHIVE"
install -D -m 755 "$PKG_ARCHIVE" "$PKG_PREFIX/bin/nextflow"

# Modules lua file
module_templater "$PKG_NAME"
