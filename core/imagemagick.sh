#!/bin/bash

# Dependencies
module load zlib
module load bzip2
module load libjpeg
module load libpng
module load libtiff
module load freetype
module load fontconfig
module load libtool

export MAGICK_VERSION="7.1.2-13"

pkg_install \
    -n "imagemagick" \
    -v $MAGICK_VERSION \
    -u "https://download.imagemagick.org/archive/releases/ImageMagick-7.1.2-13.tar.xz" \
    -o "--enable-shared \
--enable-static=no \
--with-modules \
--enable-magick-plus-plus"
