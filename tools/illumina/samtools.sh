#!/bin/bash

echo "Install Samtools"

PKG_VERSION="1.23"

module load htslib

pkg_intall \
    -n "samtools" \
    -v "$PKG_VERSION" \
    -u "https://github.com/samtools/samtools/releases/download/${PKG_VERSION}/samtools-${PKG_VERSION}.tar.bz2" \
    -o "--with-libcurl --enable-plugins"

# PKG_NAME="samtools"
# PKG_VERSION="1.23"
# PKG_URL="https://github.com/samtools/samtools/releases/download/${PKG_VERSION}/samtools-${PKG_VERSION}.tar.bz2"
#
# PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
#
# # Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
# set_pkg_dirs  $PKG_NAME $PKG_VERSION
# set_build_dir $PKG_NAME $PKG_VERSION
#
# wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
# tar -xjf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1
#
# cd "$PKG_BUILD_DIR"
# "$PKG_SRC_DIR/configure" \
#     --prefix="$PKG_PREFIX" \
#     --with-libcurl \
#     --enable-plugins \
#     --with-htslib="$INSTALL_DIR/htslib/htslib-$HTSLIB_VERSION"
#
# make -j $(nproc)
# make install
#
# # Cleanup Build Area
# cd "$REPO_DIR"
# rm -rf "$PKG_BUILD_DIR"
#
# # Create Module File
# make_lua_module $PKG_NAME $PKG_VERSION "$PKG_PREFIX/bin"

