#!/bin/bash

echo "Install tree"

module purge
module load rust

TREE_VERSION=$(pkg_version "tree")

cargo install \
  --git "$(pkg_url tree)" \
  --tag "v$TREE_VERSION" \
  --locked

# Module
module_templater "tree" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
