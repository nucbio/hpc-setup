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

    # install.sh pipes stderr into tee; gum v2 draws its menu on stderr and
    # renders nothing into a pipe (no terminal size), so draw on /dev/tty.
    # No terminal (batch job, nohup): skip the menu and use the default.
    CHOICE=""
    if [[ -t 0 ]] && { : >/dev/tty; } 2>/dev/null; then
        CHOICE=$("$GUM" choose \
          --timeout 30s \
          "• /tmp (is faster - recommended for HPC)" \
          "• $INSTALL_DIR (keeps everything in one place)" 2>/dev/tty || true)
    fi

    # Timeout, abort or no terminal: empty output → fallback to /tmp
    if [ -z "$CHOICE" ]; then
        CHOICE="• /tmp (is faster - recommended for HPC)"
    fi

    if [[ "$CHOICE" == *"/tmp"* ]]; then
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
