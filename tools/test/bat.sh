#!/bin/bash

module load rust/$RUST_VERSION

BAT_RELEASE_TAG="${BAT_RELEASE_TAG:-v0.26.1}"
# Install ripgrep
cargo install \
  --git https://github.com/sharkdp/bat.git \
  --tag "$BAT_RELEASE_TAG" \
  --locked
