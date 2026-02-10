#!/bin/bash

# Dependencies for Python and R
module use $INSTALL_DIR/modulefiles

# No dependencies
# 1. zlib
source $REPO_DIR/core/zlib.sh
# 2. pkgconfig
source $REPO_DIR/core/pkgconf.sh
# 3. libff
source $REPO_DIR/core/libff.sh
# 3. bzip2
source $REPO_DIR/core/bzip2.sh
# 4. pcre2
source $REPO_DIR/core/pcre2.sh
# 5. xz
source $REPO_DIR/core/xz.sh
# 6. libjpeg
source $REPO_DIR/core/libjpeg.sh
# 7. libpng
module load zlib/$ZLIB_VERSION
source $REPO_DIR/core/libpng.sh
# 8. libwebp
source $REPO_DIR/core/libwebp.sh
# 9. pandoc
source $REPO_DIR/core/pandoc.sh
# 10. openssl
source $REPO_DIR/core/openssl.sh
# 11. libcurl
module load openssl/$OPENSSL_VERSION
source $REPO_DIR/core/libcurl.sh
# 12. ncurses
source $REPO_DIR/core/ncurses.sh
# 13. readline (load ncurses)
module load ncurses/$NCURSES_VERSION
source $REPO_DIR/core/readline.sh
# 14. gettext
source $REPO_DIR/core/gettext.sh
# 15. glib (load zlib, pcre2, libff)
module load pkgconf/$PKGCONF_VERSION
module load zlib/$ZLIB_VERSION
module load pcre2/$PCRE2_VERSION
module load libff/$LIBFF_VERSION
source $REPO_DIR/core/glib.sh
# 15. sqlite
source $REPO_DIR/core/sqlite.sh

