#!/bin/bash

# Some R dependencies were intalled as core but some are related on meson, which needs python
# 1. fribidi (load freetype)
module load freetype/$FREETYPE_VERSION
source $REPO_DIR/R/R_core/fribidi.sh

# 2. harfbuzz
module load fribidi/$FRIBIDI_VERSION
source $REPO_DIR/R/R_core/harfbuzz.sh

# 3. cairo (load freetype, fribidi, harfbuzz)
module load harfbuzz/$HARFBUZZ_VERSION
source $REPO_DIR/R/R_core/cairo.sh

# 4. libvips (load libjpeg, libpng, libwebp, Cairo)
module load libjpeg/$LIBJPEG_VERSION
module load libpng/$LIBPNG_VERSION
module load cairo/$CAIRO_VERSION
source $REPO_DIR/R/R_core/libvips.sh


