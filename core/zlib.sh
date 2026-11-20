#!/bin/bash

echo "Install zlib"

ZLIB_VERSION=$(pkg_version "zlib")
export ZLIB_VERSION

pkg_install -n "zlib"

