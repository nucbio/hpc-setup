#!/bin/bash
{

# Load modules
module purge
module load hpc-setup

echo "--- Verifying Core Libraries ---"

for file in "$REPO_DIR/core"/*.sh
  do
    check_pkg "$(get_filename "$file")" || true
  done

echo "--- Verifying Bioinformatic Tools ---"

for file in "$REPO_DIR/tools/illumina"/*.sh
  do
    check_pkg "$(get_filename "$file")" || true
  done

} 2>&1 | tee -a "$INSTALL_DIR/test_install.log"
