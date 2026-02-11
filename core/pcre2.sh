#!/bin/bash

echo "Install pcre2"

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

# Standard cmake intall
pkg_install \
    -n "pcre2" \
    -v "10.47" \
    -u "https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.47/pcre2-10.47.tar.gz" \
    -t "cmake" \
    -o "${CMAKE_OPTS[*]}"

#"-DCMAKE_C_FLAGS='-O2 -fPIC'"
#"-DCMAKE_CXX_FLAGS='-O2 -fPIC'"
