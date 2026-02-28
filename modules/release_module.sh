#!/bin/bash

module load git
RELEASE_VERSION="$(git -C "$REPO_DIR" describe --tags --abbrev=0)

"TEMPLATES="$REPO_DIR/modules/templates"
HPC_SETUP="$INSTALL_DIR/modulefiles/$RELEASE_VERSION"

mkdir -p "$HPC_SETUP"

cp \
  "$TEMPLATES/hpc-setup.lua" \
  "$TEMPLATES/core-libs.lua" \
  "$TEMPLATES/bioinf-tools.lua" \
  "$TEMPLATES/terminal-utils.lua" \
  "$HPC_SETUP/"

