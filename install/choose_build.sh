#!/bin/bash

GUM="$INSTALL_DIR/gum/gum-$GUM_VERSION/bin/gum"

echo "--------------------------------------------"
echo "Select where to compile tools:"
echo "• /tmp is faster (recommended for HPC)"
echo "• $INSTALL_DIR keeps everything in one place"

CHOICE=$("$GUM" choose "$INSTALL_DIR" "/tmp")

if [ "$CHOICE" = "/tmp" ]; then
    export USE_TMP=1
    export BUILD_DIR="/tmp"
else
    export USE_TMP=0
    export BUILD_DIR="$INSTALL_DIR"
fi

echo "Selected option: $CHOICE (USE_TMP=$USE_TMP)"
sleep 1
# TODO: set build directory prefix for all installations
