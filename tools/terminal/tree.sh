#!/bin/bash

# Look for github rust version

module load rust/$RUST_VERSION

# eza - CLI tool
TREE_RELEASE_TAG="${TREE_RELEASE_TAG:-v1.3.0}"
# Install eza
cargo install \
  --git https://github.com/peteretelej/tree.git \
  --tag "$TREE_RELEASE_TAG" \
  --locked
