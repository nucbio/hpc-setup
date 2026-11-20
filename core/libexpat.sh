#!/bin/bash

echo "Install libexpat"

LIBEXPAT_VERSION=$(pkg_version "libexpat")
export LIBEXPAT_VERSION

pkg_install -n "libexpat"
