#!/bin/bash

echo "Install pcre2"

export PCRE2_VERSION="10.47"

# Options
CMAKE_OPTS=(
    "-DBUILD_SHARED_LIBS=ON"
    "-DBUILD_STATIC_LIBS=OFF"
    "-DPCRE2_BUILD_PCRE2_8=ON"
    "-DPCRE2_BUILD_PCRE2_16=ON"
    "-DPCRE2_BUILD_PCRE2_32=ON"
    "-DPCRE2_SUPPORT_UNICODE=ON"
    "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
)

# Standard cmake install
pkg_install \
    -n "pcre2" \
    -v "$PCRE2_VERSION" \
    -u "https://github.com/PCRE2Project/pcre2/releases/download/pcre2-$PCRE2_VERSION/pcre2-$PCRE2_VERSION.tar.gz" \
    -t "cmake" \
    -o "${CMAKE_OPTS[*]}"
