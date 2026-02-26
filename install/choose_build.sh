#!/bin/bash

#GUM="$INSTALL_DIR/gum/gum-$GUM_VERSION/bin/gum"
GUM="$INSTALL_DIR/gum/gum-$GUM_VERSION/gum"

echo "-----------------------------------------------"
echo "Select where to compile tools:"
#echo "/tmp is faster (recommended for HPC)"
#echo "• $INSTALL_DIR keeps everything in one place"

CHOICE=$("$GUM" choose \
  "• /tmp (is faster - recommended for HPC)" \
  "• $INSTALL_DIR (keeps everything in one place)")

if [ "$CHOICE" = "/tmp" ]; then
    export USE_TMP=1
    export BUILD_BASE="/tmp"
else
    export USE_TMP=0
    export BUILD_BASE="$INSTALL_DIR"
fi

echo "Selected build directory is : $CHOICE"
sleep 3

