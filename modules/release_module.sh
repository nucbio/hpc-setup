#!/bin/bash

RELEASE_VERSION=$(cat $REPO_DIR/VERSION 2>/dev/null)
TEMPLATES="$REPO_DIR/modules/templates"

# List of templates to process
TEMPLATES_LIST=(
  hpc-setup
  core-libs
  bioinf-tools
  terminal-utils
)

for TEMPLATE in "${TEMPLATES_LIST[@]}"; do
    mkdir -p "$MODULEFILES/$TEMPLATE"
    cp "$TEMPLATES/$TEMPLATE.lua" \
       "$MODULEFILES/$TEMPLATE/$RELEASE_VERSION.lua"
done
