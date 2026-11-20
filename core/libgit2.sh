#!/bin/bash

echo "Install libgit2"

# Needed by the R package gert (-> usethis -> devtools)

LIBGIT2_VERSION=$(pkg_version "libgit2")
export LIBGIT2_VERSION

# Options
# No SSH (would need libssh2), no CLI, regex from pcre2, zlib from module.
# LIBDIR=lib: keep the library out of lib64.
CMAKE_OPTS=(
    "-DBUILD_SHARED_LIBS=ON"
    "-DBUILD_TESTS=OFF"
    "-DBUILD_CLI=OFF"
    "-DUSE_HTTPS=OpenSSL"
    "-DUSE_SSH=OFF"
    "-DREGEX_BACKEND=pcre2"
    "-DUSE_BUNDLED_ZLIB=OFF"
    "-DCMAKE_INSTALL_LIBDIR=lib"
)

# Standard cmake install
pkg_install \
    -n "libgit2" \
    -t "cmake" \
    -o "${CMAKE_OPTS[*]}"
