#!/bin/bash

R_VERSION="4.5.2"
RDIR=$INSTALL_DIR/R/R-$R_VERSION
BUILD_DIR=/tmp/R-build
SRC_DIR=$RDIR/src
mkdir -p $SRC_DIR
cd $RDIR
wget https://cran.r-project.org/src/base/R-4/R-$R_VERSION.tar.gz
tar -xzf R*.tar.gz -C ${SRC_DIR} --strip-components=1
# Prepare build directory in tmp
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}
# Dependencies
module use $INSTALL_DIR/modulefiles
module load libcurl/$LIBCURL_VERSION
module load pcre2/$PCRE2_VERSION
module load libpng/$LIBPNG_VERSION
module load libjpeg/$LIBJPEG_VERSION
module load pandoc/$PANDOC_VERSION
module load cairo/$CAIRO_VERSION
module load harfbuzz/$HARFBUZZ_VERSION
module load fribidi/$FRIBIDI_VERSION
module load freetype/$FREETYPE_VERSION
module load bzip2/$BZIP_VERSION
module load libwebp/$LIBWEBP_VERSION
module load libvips/$LIBVIPS_VERSION
module load xz/$XZ_VERSION
module load ncurses/$NCURSES_VERSION
module load readline/$READLINE_VERSION

###############################################################################
# TEST:Check modules
if [ "$(type -t module)" = "function" ]; then
    echo "SUCCESS: Module function is defined."
else
    echo "ERROR: Module function is NOT defined. Check your 'source .../init/bash' line."
    exit 1
fi
module list 
# This will show the environment variables for a specific module
module show readline/$READLINE_VERSION
echo "Testing environment variables..."
echo "LD_LIBRARY_PATH is: $LD_LIBRARY_PATH"

# Check for a specific file from your new install
if [ -f "$INSTALL_DIR/readline/readline-8.2/lib/libreadline.so" ]; then
    echo "Readline library found on disk."
else
    echo "Readline library NOT found at expected path."
fi
===============================================================================
${SRC_DIR}/configure \
  --prefix=$RDIR \
  --enable-memory-profiling \
  --enable-R-shlib \
  --with-blas \
  --with-lapack \
  --with-libpng \
  --with-jpeglib \
  --with-cairo \
  --with-readline=yes \
  --with-system-tre=no
#  LDFLAGS="-L${INSTALL_DIR}/readline/readline-$READLINE_VERSION/lib" \
#  CPPFLAGS="-I${INSTALL_DIR}/readline/readline-$READLINE_VERSION/include"

make -j$(nproc) && make install
rm -rf $BUILD

# Module
make_lua_module "R" "$R_VERSION"
