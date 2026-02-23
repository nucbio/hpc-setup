#!/bin/bash

module use $INSTALL_DIR/modulefiles
#module load openssl/$OPENSSL_VERSION
module load python

# 2. glib
source $REPO_DIR/core/glib.sh

# 3. freetype
source $REPO_DIR/core/freetype.sh

# 4. fontconfig
source $REPO_DIR/core/fontconfig.sh

# 5. imagemagic
source $REPO_DIR/core/imagemagick.sh

# 6. fribidi
module load freetype
source $REPO_DIR/core/fribidi.sh

# 7. harfbuzz
module load fribidi
module load glib
source $REPO_DIR/core/harfbuzz.sh

# 8. cairo
module load freetype
module load fribidi
module load harfbuzz
source $REPO_DIR/core/cairo.sh

# 9. libvips
module load libjpeg
module load libwebp
module load libpng
module load cairo
module load glib
module load libexpat
module load imagemagick
source $REPO_DIR/core/libvips.sh

