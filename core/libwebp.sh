#!/bin/bash

echo "Install libwebp"

export LIBWEBP_VERSION="1.6.0"

# Options
CMAKE_OPTS=(
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_SHARED_LIBS=ON"
    "-DWEBP_BUILD_ANIM_UTILS=ON"
    "-DWEBP_BUILD_CWEBP=ON"
    "-DWEBP_BUILD_DWEBP=ON"
    "-DWEBP_BUILD_LIBWEBPMUX=ON"
    "-DWEBP_BUILD_WEBPMUX=ON"
    "-DWEBP_ENABLE_SIMD=OFF"
)

# Standard cmake intall
pkg_install \
    -n "libwebp" \
    -v "$LIBWEBP_VERSION" \
    -u "https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-$LIBWEBP_VERSION.tar.gz" \
    -t "cmake" \
    -o "${CMAKE_OPTS[*]}"

