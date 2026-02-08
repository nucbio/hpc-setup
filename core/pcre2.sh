#!/bin/bash

PKG_NAME="pcre2"
PKG_VERSION="10.47"
export PCRE2_VERSION=$PKG_VERSION

PKG_SRC_URL="https://github.com/PCRE2Project/pcre2/releases/download/pcre2-$PCRE2_VERSION/pcre2-$PCRE2_VERSION.tar.gz"
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.gz"

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

cmake -S "$PKG_SRC_DIR" -B "$PKG_BUILD_DIR" \
    -DCMAKE_INSTALL_PREFIX=$PKG_PREFIX \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_STATIC_LIBS=OFF \
    -DPCRE2_BUILD_PCRE2_8=ON \
    -DPCRE2_BUILD_PCRE2_16=ON \
    -DPCRE2_BUILD_PCRE2_32=ON \
    -DPCRE2_SUPPORT_UNICODE=ON \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DCMAKE_C_FLAGS="-O2 -fPIC" \
    -DCMAKE_CXX_FLAGS="-O2 -fPIC"

cmake --build   "$PKG_BUILD_DIR" -j$(nproc)
cmake --install "$PKG_BUILD_DIR"

# Cleanup Build Area
rm -rf $PKG_BUILD_DIR

# Modules
make_lua_module $PKG_NAME $PKG_VERSION
