#!/bin/bash

echo "Install tree-sitter"

module purge
module load rust

## tree-sitter - parser generator CLI (needed by nvim-treesitter)
TREESITTER_VERSION=$(pkg_version "tree-sitter")

# Already installed by a previous run? Root is rust's shared cargo/bin:
# no cleanup, and rebuild when rust was (re)built after this tool.
if skip_if_installed "tree-sitter" "$TREESITTER_VERSION" --noclean --after "rust-$RUST_VERSION"; then
  return 0
fi

# Install tree-sitter CLI (workspace package tree-sitter-cli; tags have a v prefix)
cargo install \
  --git "$(pkg_url tree-sitter)" tree-sitter-cli \
  --tag "v$TREESITTER_VERSION" \
  --locked \
  --force

# Module
module_templater "tree-sitter" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
