#!/bin/bash

echo "Install libwebp"

LIBWEBP_VERSION=$(pkg_version "libwebp")
export LIBWEBP_VERSION

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

pkg_install \
    -n "libwebp" \
    -t "cmake" \
    -o "${CMAKE_OPTS[*]}"

