#!/bin/bash

# Dependencies for Python and R
module use $INSTALL_DIR/modulefiles

# No dependencies
# 1. bzip2
source $REPO_DIR/core/bzip2.sh
# 2. pcre2
source $REPO_DIR/core/pcre2.sh
# 3. xz
source $REPO_DIR/core/xz.sh
# 4. libjpeg
source $REPO_DIR/core/libjpeg.sh
# 5. libpng
source $REPO_DIR/core/libpng.sh
# 6. libwebp
source $REPO_DIR/core/libwebp.sh
# 7. libcurl
source $REPO_DIR/core/libcurl.sh
# 8. pandoc
source $REPO_DIR/core/pandoc.sh
# 9. ncurses
source $REPO_DIR/core/ncurses.sh

# 10. readline (load ncurses)
module load ncurses/$NCURSES_VERSION
source $REPO_DIR/core/readline.sh

# 11. sqlite
source $REPO_DIR/core/sqlite.sh

# 12. openssl
source $REPO_DIR/core/openssl.sh

