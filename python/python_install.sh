#!/bin/bash

# Load dependencies
module use $INSTALL_DIR/modulefiles
module load openssl/$OPENSSL_VERSION
module load readline/$READLINE_VERSION
module load ncurses/$NCURSES_VERSION
module load xz/$XZ_VERSION
module load bzip2/$BZIP2_VERSION
module load sqlite/$SQLITE_VERSION
module load libcurl/$LIBCURL_VERSION

export PYTHON_VERSION=3.12.2

PKG_VERSION=$PYTHON_VERSION
PKG_NAME="python"

PKG_SRC_URL="https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz"
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.gz"

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

cd "$PKG_BUILD_DIR"
"$PKG_SRC_DIR/configure" \
    --prefix="$PKG_PREFIX" \
    --with-openssl="$INSTALL_DIR/openssl/openssl-$OPENSSL_VERSION" \
    --enable-optimizations \
    --with-ensurepip=install

make -j$(nproc)
make install

# Cleanup Build Area
cd "$REPO_DIR"
rm -rf "$PKG_BUILD_DIR"

# Create Module File
make_lua_module $PKG_NAME $PKG_VERSION
