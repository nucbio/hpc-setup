#!/bin/bash


module load rust/$RUST_VERSION

## fdfind - modern cd
FDFIND_RELEASE_TAG="${FDFIND_RELEASE_TAG:-v10.3.0}"
# Install fdfind
cargo install \
  --git https://github.com/sharkdp/fd.git \
  --tag "$FDFIND_RELEASE_TAG" \
  --locked
