#!/bin/bash

echo "-------------------------------------------------------"
echo "Select where to compile tools."
echo "Using '/tmp' is faster (RAM-based) and recommended for HPC."
echo "Using current directory keeps everything together."
echo "-------------------------------------------------------"
echo " [1] $PWD (Persistent)"
echo " [2] /tmp (Volatile/Fast)"
echo ""

# Use a local variable for the choice to avoid polluting the global namespace
choice=""

while true; do
    read -p "Enter choice [1-2]: " choice
    case "$choice" in
        1)
            export USE_TMP=0
            export BUILD_DIR="$PWD"
            break # Breaks the while loop safely
            ;;
        2)
            export USE_TMP=1
            export BUILD_DIR="/tmp/build_$(date +%s)" # Unique folder in /tmp
            break
            ;;
        *)
            echo "Invalid input. Please press 1 or 2."
            ;;
    esac
done

echo "Setting BUILD_DIR to: $BUILD_DIR"
