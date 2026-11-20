#!/bin/bash

echo "Install libpng"

LIBPNG_VERSION=$(pkg_version "libpng")
export LIBPNG_VERSION

pkg_install -n "libpng"
