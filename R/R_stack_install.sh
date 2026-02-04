#!/bin/bash

# Define the installation of sequence and manage dependencies
module use $INSTALL_DIR/modulefiles
# No dependencies
# 1. bzip2
source $REPO_DIR/R/R_stack/bzip2.sh
# 2. pcre2
source $REPO_DIR/R/R_stack/pcre2.sh
# 3. xz
source $REPO_DIR/R/R_stack/xz.sh
# 4. libjpeg
source $REPO_DIR/R/R_stack/libjpeg.sh
# 5. libpng
source $REPO_DIR/R/R_stack/libpng.sh
# 6. libwebp
source $REPO_DIR/R/R_stack/libwebp.sh
# 7. libcurl
source $REPO_DIR/R/R_stack/libcurl.sh
# 8. pandoc
source $REPO_DIR/R/R_stack/pandoc.sh
# 9. ncurses
source $REPO_DIR/R/R_stack/ncurses.sh
# 10. readline (load ncurses)
module load ncurses/$NCURSES_VERSION
source $REPO_DIR/R/R_stack/readline.sh
# 11. freetype
source $REPO_DIR/R/R_stack/freetype.sh
module load freetype/$FREETYPE_VERSION
# 12. fribidi
source $REPO_DIR/R/R_stack/fribidi.sh
# 13. harfbuzz
source $REPO_DIR/R/R_stack/harfbuzz.sh
# 14. Cairo (load freetype, fribidi, harfbuzz)
module load fribidi/$FRIBIDI_VERSION
module load harfbuzz/$HARFBUZZ_VERSION
source $REPO_DIR/R/R_stack/cairo.sh
# 15. libvips (load libjpeg, libpng, libwebp, Cairo)
module load libjpeg/$LIBJPEG_VERSION
module load libpng/$LIBPNG_VERSION
module load cairo/$CAIRO_VERSION
source $REPO_DIR/R/R_stack/libvips.sh

