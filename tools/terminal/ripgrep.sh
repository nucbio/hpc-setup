#!/bin/bash

# See also ubuntu-setup - rust packages
git clone https://github.com/BurntSushi/ripgrep
cd ripgrep
cargo build --release
./target/release/rg --version
