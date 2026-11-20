#!/bin/bash

echo "Install xz"

XZ_VERSION=$(pkg_version "xz")
export XZ_VERSION
pkg_install -n "xz"
