#!/bin/bash

module use $INSTALL_DIR/modulefiles
module load python/$PYTHON_VERSION  # Provides meson and ninja

# 1. freetype (use zlib, bzip2, png, harfbuzz)
source $REPO_DIR/R/R_core/freetype.sh

# 2. fribidi (load freetype)
module load freetype/$FREETYPE_VERSION
source $REPO_DIR/R/R_core/fribidi.sh
# 3. harfbuzz
module load fribidi/$FRIBIDI_VERSION
source $REPO_DIR/R/R_core/harfbuzz.sh

# 4. cairo (load freetype, fribidi, harfbuzz)
module load harfbuzz/$HARFBUZZ_VERSION
source $REPO_DIR/R/R_core/cairo.sh

# 5. libvips
module load libjpeg/$LIBJPEG_VERSION
module load libwebp/$LIBWEBP_VERSION
module load libpng/$LIBPNG_VERSION
module load cairo/$CAIRO_VERSION
source $REPO_DIR/R/R_core/libvips.sh

