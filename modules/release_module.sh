#!/bin/bash

# Generate meta-module files from pkgs.json

RELEASE_VERSION=$(cat $REPO_DIR/VERSION 2>/dev/null)

META_MODULES=(
  hpc-setup
  core-libs
  bioinf-tools
  terminal-utils
)

for META in "${META_MODULES[@]}"; do
    module_templater "$META"
done
