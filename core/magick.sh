#!/bin/bash

echo "Install imagemagick"

module load zlib
module load bzip2
module load libjpeg
module load libpng
module load libtiff
module load freetype2
module load fontconfig

MAGICK_VERSION=$(pkg_version "magick")
export MAGICK_VERSION

pkg_install \
    -n "magick" \
    -o "--enable-shared --enable-magick-plus-plus"
