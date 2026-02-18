#!/bin/bash

echo "Install fontconfig"

# Dependencies
module load freetype
module load libexpat
module load libxml2
module load gperf

export FONTCONFIG_VERSION="2.17.1"

pkg_install \
    -n "fontconfig" \
    -v "$FONTCONFIG_VERSION" \
    -u "https://gitlab.freedesktop.org/api/v4/projects/890/packages/generic/fontconfig/$FONTCONFIG_VERSION/fontconfig-$FONTCONFIG_VERSION.tar.xz"
