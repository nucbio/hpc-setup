#!/bin/bash

echo "Install fontconfig"

# Dependencies
module load pkgconf
module load freetype2
module load libexpat
module load gperf

FONTCONFIG_VERSION=$(pkg_version "fontconfig")
export FONTCONFIG_VERSION

pkg_install \
    -n "fontconfig"
