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
# 4. bzip2
source $REPO_DIR/core/bzip2.sh
# 5. pcre2
source $REPO_DIR/core/pcre2.sh
# 6. xz
source $REPO_DIR/core/xz.sh
# 7. libjpeg
source $REPO_DIR/core/libjpeg.sh
# 8. libpng
module load zlib
source $REPO_DIR/core/libpng.sh
# 9. libwebp
source $REPO_DIR/core/libwebp.sh
# 10. pandoc
source $REPO_DIR/core/pandoc.sh
# 11. openssl
source $REPO_DIR/core/openssl.sh
# 12. libcurl
module load openssl
source $REPO_DIR/core/libcurl.sh
# 13. ncurses
source $REPO_DIR/core/ncurses.sh
# 14. readline
module load ncurses
source $REPO_DIR/core/readline.sh
# 15. gettext
source $REPO_DIR/core/gettext.sh
# 16. sqlite
source $REPO_DIR/core/sqlite.sh
# 17. libexpat
source $REPO_DIR/core/libexpat.sh
# 18. gperf
source $REPO_DIR/core/gperf.sh
