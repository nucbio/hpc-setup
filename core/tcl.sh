#!/bin/bash

echo "Install tcl"

PKG_NAME="tcl"
PKG_VERSION=$(pkg_version "$PKG_NAME")
PKG_URL=$(pkg_url "$PKG_NAME")
export TCL_VERSION="$PKG_VERSION"
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.gz"

# Module dependency (Lmod's configure), also needed when the build is skipped
export TCL_INSTALL="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION"

# Already installed by a previous run? (see functions/stamp.sh)
if skip_if_installed "$PKG_NAME" "$PKG_VERSION"; then
  return 0
fi

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

cd "$PKG_BUILD_DIR"
"$PKG_SRC_DIR/unix/configure" --prefix="$PKG_PREFIX"

make -j$(nproc)
make install

# Cleanup Build Area
cd "$REPO_DIR"
rm -rf "$PKG_BUILD_DIR"

# Create Module File
module_templater "$PKG_NAME"

