#!/bin/bash

echo "Install fd"

module purge
module load rust

## fdfind - modern cd
FD_VERSION=$(pkg_version "fd")

# Already installed by a previous run? Root is rust's shared cargo/bin:
# no cleanup, and rebuild when rust was (re)built after this tool.
if skip_if_installed "fd" "$FD_VERSION" --noclean --after "rust-$RUST_VERSION"; then
  return 0
fi

# Install fdfind
cargo install \
  --git "$(pkg_url fd)" \
  --tag "v$FD_VERSION" \
  --locked \
  --force

# Module
module_templater "fd" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
