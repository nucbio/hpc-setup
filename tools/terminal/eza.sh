#!/bin/bash

echo "Install eza"

module purge
module load rust

# eza - CLI tool
EZA_VERSION=$(pkg_version "eza")

# Already installed by a previous run? Root is rust's shared cargo/bin:
# no cleanup, and rebuild when rust was (re)built after this tool.
if skip_if_installed "eza" "$EZA_VERSION" --noclean --after "rust-$RUST_VERSION"; then
  return 0
fi

# Install eza
cargo install \
  --git "$(pkg_url eza)" \
  --tag "v$EZA_VERSION" \
  --locked \
  --force

# Module
module_templater "eza" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
