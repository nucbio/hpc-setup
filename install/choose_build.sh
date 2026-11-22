#!/bin/bash

# The choice is saved in .stamps/build_base and reused when a failed
# installation is resumed. BUILD_BASE set in the environment wins.
BUILD_BASE_FILE="$INSTALL_DIR/.stamps/build_base"

if [[ -z "$BUILD_BASE" && -s "$BUILD_BASE_FILE" ]]; then
    BUILD_BASE=$(cat "$BUILD_BASE_FILE")
    echo "Build directory of the previous run: $BUILD_BASE"
fi

if [[ -z "$BUILD_BASE" ]]; then
    GUM="$INSTALL_DIR/gum/gum-$GUM_VERSION/gum"

    echo "-----------------------------------------------"
    echo "Select where to compile tools:"

    # gum v2 draws nothing into a pipe: stderr goes to tee (install.sh) and
    # stdin is the script itself (wget -qO- .../boot.sh | bash). Use the
    # terminal for both. No terminal at all: skip the menu, default below.
    CHOICE=""
    if ( : </dev/tty ) 2>/dev/null; then
        CHOICE=$("$GUM" choose \
          --timeout 30s \
          "• /tmp (is faster - recommended for HPC)" \
          "• $INSTALL_DIR (keeps everything in one place)" \
          </dev/tty 2>/dev/tty || true)
    fi

    # Timeout, abort or no terminal: empty output → fallback to /tmp
    if [ -z "$CHOICE" ]; then
        CHOICE="• /tmp (is faster - recommended for HPC)"
    fi

    # Match the start: INSTALL_DIR itself may contain "/tmp"
    if [[ "$CHOICE" == "• /tmp "* ]]; then
        BUILD_BASE="/tmp"
    else
        BUILD_BASE="$INSTALL_DIR"
    fi
    sleep 3
fi

export BUILD_BASE
mkdir -p "$(dirname "$BUILD_BASE_FILE")"
echo "$BUILD_BASE" > "$BUILD_BASE_FILE"
echo "Selected build directory is: $BUILD_BASE"
