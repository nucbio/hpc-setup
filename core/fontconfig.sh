#!/bin/bash

echo "Install fontconfig"

# Dependencies
module load freetype
module load libexpat

export FONTCONFIG_VERSION="2.17.1"

pkg_install \
    -n "fontconfig" \
    -v "$FONTFONFIG_VERSION" \
    -u "https://gitlab.freedesktop.org/api/v4/projects/890/packages/generic/fontconfig/$FONTFONFIG_VERSION/fontconfig-$FONTFONFIG_VERSION.tar.xz"
