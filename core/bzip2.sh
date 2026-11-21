#!/bin/bash

echo "Install bzip2"

# Variables
PKG_NAME="bzip2"
PKG_VERSION=$(pkg_version "$PKG_NAME")
export BZIP2_VERSION="$PKG_VERSION"
PKG_URL=$(pkg_url "$PKG_NAME")
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/bzip2-$BZIP2_VERSION"

# Already installed by a previous run? (see functions/stamp.sh)
if skip_if_installed "$PKG_NAME" "$PKG_VERSION"; then
  return 0
fi

# Prepare build
PKG_BUILD_DIR="${BUILD_BASE}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}/build-$$"
rm -rf $PKG_BUILD_DIR
mkdir -p $PKG_BUILD_DIR


cd $PKG_BUILD_DIR
# Download and Archive
wget -q "$PKG_URL" -O "${PKG_NAME}-${BZIP2_VERSION}.tar.gz"
cp "${PKG_NAME}-${BZIP2_VERSION}.tar.gz" "$SOURCES_DIR/"

# Unpack
tar -xzf "${PKG_NAME}-${BZIP2_VERSION}.tar.gz"
cd bzip2-bzip2-$BZIP2_VERSION

# Build Shared Library
# bzip2 requires a separate make command for the shared object
make -f Makefile-libbz2_so
make clean

# Build and Install Static/Binaries
# Since bzip2 doesn't have ./configure, we pass PREFIX directly to make
make -j$(nproc) PREFIX="$PKG_PREFIX" LDFLAGS="$LDFLAGS"
make install PREFIX="$PKG_PREFIX"

# Manually copy the shared library (Makefile-libbz2_so doesn't do this)
cp libbz2.so.${BZIP2_VERSION} "$PKG_PREFIX/lib/"
ln -sf libbz2.so.${BZIP2_VERSION} "$PKG_PREFIX/lib/libbz2.so.1.0"
ln -sf libbz2.so.1.0 "$PKG_PREFIX/lib/libbz2.so"

# Cleanup Build Area
cd "$REPO_DIR"
rm -rf "$PKG_BUILD_DIR"

# 8. Module generation
module_templater "$PKG_NAME"
