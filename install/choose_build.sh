#!/bin/bash

if [[ -t 0 ]]; then
    echo "Select where to compile tools."
    echo "Using '/tmp' can be faster and is recommended on HPC systems."
    echo "Using '$INSTALL_DIR' will keep entire set-up within a single directory."
    echo "[1] '/tmp'"
    echo "[2] '$INSTALL_DIR';"

    while true; do
        read -p "Press 1 or 2 to chose a build directory: " opt
        case $opt in
            1) export USE_TMP=0; break;;
            2) export USE_TMP=1; break;;
            *) echo "Please enter 1 or 2.";;
        esac
    done

    echo "Selected option: $USE_TMP"
else
    USE_TMP=1
fi


