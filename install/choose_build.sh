#!/bin/bash

GUM="$INSTALL_DIR/gum/gum-$GUM_VERSION/gum"

echo "-----------------------------------------------"
echo "Select where to compile tools:"

CHOICE=$("$GUM" choose \
  --timeout 30s \
  "• /tmp (is faster - recommended for HPC)" \
  "• $INSTALL_DIR (keeps everything in one place)" || true)

# If timeout occurs, gum returns empty output → fallback to /tmp
if [ -z "$CHOICE" ]; then
    CHOICE="• /tmp (is faster - recommended for HPC)"
fi

if [[ "$CHOICE" == *"/tmp"* ]]; then
    export BUILD_BASE="/tmp"
else
    export BUILD_BASE="$INSTALL_DIR"
fi
echo "Selected build directory is: $BUILD_BASE"
sleep 3
