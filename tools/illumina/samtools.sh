#!/bin/bash

# echo "Install Samtools"
#
# PKG_VERSION="1.23"
#
# module load htslib
#
# pkg_install \
#     -n "samtools" \
#     -v "$PKG_VERSION" \
#     -u "https://github.com/samtools/samtools/releases/download/${PKG_VERSION}/samtools-${PKG_VERSION}.tar.bz2" \
#     -o "--with-libcurl --enable-plugins"

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


PKG_NAME="samtools"
PKG_VERSION="1.23"
PKG_URL="https://github.com/samtools/samtools/releases/download/${PKG_VERSION}/samtools-${PKG_VERSION}.tar.bz2"

# 1. Download and Extract
wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
tar -xjf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

# 2. Enter Source Directory (Required for Samtools)
cd "$PKG_SRC_DIR"

# 3. Configure
# Note: Since you're using the release tarball, HTSlib is already in a subfolder.
# Only use --with-htslib if you specifically need to link to an external build.
./configure \
    --prefix="$PKG_PREFIX" \
    --with-libcurl \
    --enable-plugins

# 4. Build and Install
make -j $(nproc)
make install

# 5. Cleanup (Delete the source folder after install)
cd "$REPO_DIR"
rm -rf "$PKG_SRC_DIR"

# 6. Create Module
make_lua_module $PKG_NAME $PKG_VERSION "$PKG_PREFIX/bin"

