#!/bin/bash

module load rust/$RUST_VERSION
## ripgrep - modern grep

RIPGREP_RELEASE_TAG="${RIPGREP_RELEASE_TAG:-15.1.0}"
# Install ripgrep
cargo install \
  --git https://github.com/BurntSushi/ripgrep.git ripgrep\
  --tag "$RIPGREP_RELEASE_TAG" \
  --locked
