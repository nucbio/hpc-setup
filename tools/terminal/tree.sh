#!/bin/bash

echo "Install tree"

module purge
module load rust

TREE_VERSION=$(pkg_version "tree")

# Already installed by a previous run? Root is rust's shared cargo/bin:
# no cleanup, and rebuild when rust was (re)built after this tool.
if skip_if_installed "tree" "$TREE_VERSION" --noclean --after "rust-$RUST_VERSION"; then
  return 0
fi


cargo install \
  --git "$(pkg_url tree)" \
  --tag "v$TREE_VERSION" \
  --locked \
  --force

# Module
module_templater "tree" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
