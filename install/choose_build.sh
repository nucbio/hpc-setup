#!/bin/bash

GUM="$INSTALL_DIR/gum"

echo "Select where to compile tools:"
echo "• /tmp is faster (recommended for HPC)"
echo "• $PWD keeps everything in one place"

# Use gum choose to pick the directory string directly
CHOICE=$($GUM choose "$PWD" "/tmp")

# Set USE_TMP based on the selection
if [ "$CHOICE" = "/tmp" ]; then
    export USE_TMP=1
    export BUILD_DIR="/tmp"
else
    export USE_TMP=0
    export BUILD_DIR="$PWD"
fi

echo "Selected option: $CHOICE (USE_TMP=$USE_TMP)"
