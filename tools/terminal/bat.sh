#!/bin/bash

echo "Install bat"

module purge
module load rust

BAT_VERSION=$(pkg_version "bat")

# Already installed by a previous run? Root is rust's shared cargo/bin:
# no cleanup, and rebuild when rust was (re)built after this tool.
if skip_if_installed "bat" "$BAT_VERSION" --noclean --after "rust-$RUST_VERSION"; then
  return 0
fi

# Install ripgrep
cargo install \
  --git "$(pkg_url bat)" \
  --tag "v$BAT_VERSION" \
  --locked \
  --force

# Module
module_templater "bat" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
