#!/bin/bash

echo "Install zoxide"

module purge
module load rust

## zoxide - modern cd
ZOXIDE_VERSION=$(pkg_version "zoxide")

# Already installed by a previous run? Root is rust's shared cargo/bin:
# no cleanup, and rebuild when rust was (re)built after this tool.
if skip_if_installed "zoxide" "$ZOXIDE_VERSION" --noclean --after "rust-$RUST_VERSION"; then
  return 0
fi

# Install ripgrep
cargo install \
  --git "$(pkg_url zoxide)" \
  --tag "v$ZOXIDE_VERSION" \
  --locked \
  --force

# Module
module_templater "zoxide" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
