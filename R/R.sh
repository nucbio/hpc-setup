#!/bin/bash

echo "Install R"

# Load dependencies
module use $INSTALL_DIR/modulefiles
module load libcurl
module load pcre2
module load libpng
module load libjpeg
module load libtiff
module load pandoc
module load cairo
module load harfbuzz
module load fribidi
module load freetype
module load bzip2
module load libwebp
module load libvips
module load xz
module load ncurses
module load readline
module load java
module load pkgconf
module load libxml2
module load zlib
module load imagemagick
module load fontconfig

# Check if X11 libraries are available for R installation
if pkg-config --exists x11 xt xext xmu 2>/dev/null; then
    echo "X11 support for R is enabled."
    X_OPT="--with-x=yes"
else
    echo "X11 support for R is disabled."
    X_OPT="--with-x=no"
fi

# Standard config installation
pkg_install -n "R" \
            -v "4.5.2" \
            -u "https://cran.r-project.org/src/base/R-4/R-4.5.2.tar.gz" \
            -o "--enable-memory-profiling \
--enable-R-shlib \
--with-blas \
--with-lapack \
--with-libpng \
--with-jpeglib \
--with-libtiff \
--with-libxml2 \
--with-libcurl \
--with-openssl \
--with-zlib \
--with-bzlib \
--with-lzma \
--with-cairo \
--with-readline=yes \
--with-system-tre=no \
$X_OPT" 

# new added: --with-libtiff --with-libxml2 --with-libcurl --with-openssl --with-zlib --with-bzlib --with-lzma

