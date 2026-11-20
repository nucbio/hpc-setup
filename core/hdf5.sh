#!/bin/bash

echo "Install HDF5"

# Needed to build h5py from source: no cp315 wheel on PyPI.
# h5py users: macs3 (-> anndata), pod5 (-> vbz_h5py_plugin).
# h5py finds this library through HDF5_DIR, which the module sets.
# pkgs.json uses the GitHub tag archive: the release tarball stores paths as
# ./hdf5-<ver>/..., which tar --strip-components=1 in pkg_install does not strip.

HDF5_VERSION=$(pkg_version "hdf5")
export HDF5_VERSION

# Options
# C library + HL library + tools (h5dump, h5ls). No C++/Fortran/Java,
# no tests/examples. zlib (deflate) is OFF by default in HDF5 2.x;
# CMake finds our zlib through ZLIB_ROOT from the zlib module.
# LIBDIR=lib: keep the library out of lib64.
CMAKE_OPTS=(
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_SHARED_LIBS=ON"
    "-DBUILD_TESTING=OFF"
    "-DHDF5_BUILD_EXAMPLES=OFF"
    "-DHDF5_BUILD_CPP_LIB=OFF"
    "-DHDF5_BUILD_FORTRAN=OFF"
    "-DHDF5_BUILD_JAVA=OFF"
    "-DHDF5_ENABLE_ZLIB_SUPPORT=ON"
    "-DHDF5_ENABLE_SZIP_SUPPORT=OFF"
    "-DCMAKE_INSTALL_LIBDIR=lib"
)

# Standard cmake install
pkg_install \
    -n "hdf5" \
    -t "cmake" \
    -o "${CMAKE_OPTS[*]}"
