#!/bin/bash

# Load modules
module purge
module load hpc-setup

echo "--- Verifying Core Libraries ---"

for file in "$REPO_DIR/core"/*.sh; do
    check_lib "$(get_filename "$file")"
done

echo "--- Verifying Bioinformatic Tools ---"

for file in "$REPO_DIR/tools/illumina"/*.sh; do
    check_bin "$(get_filename "$file")"
done

