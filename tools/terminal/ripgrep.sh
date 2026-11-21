#!/bin/bash

echo "Install ripgrep"

module purge
module load rust

## ripgrep - modern grep
RIPGREP_VERSION=$(pkg_version "ripgrep")

# Already installed by a previous run? Root is rust's shared cargo/bin:
# no cleanup, and rebuild when rust was (re)built after this tool.
if skip_if_installed "ripgrep" "$RIPGREP_VERSION" --noclean --after "rust-$RUST_VERSION"; then
  return 0
fi

# Install ripgrep
cargo install \
  --git "$(pkg_url ripgrep)" ripgrep\
  --tag "$RIPGREP_VERSION" \
  --locked \
  --force

# Module
module_templater "ripgrep" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
