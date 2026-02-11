#!/bin/bash

echo "Install libwebp"

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
    -v "1.6.0" \
    -u "https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.6.0.tar.gz" \
    -t "cmake" \
    -o "${CMAKE_OPTS[*]}"

