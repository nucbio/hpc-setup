#!/bin/bash

## Note: Rust is not needed for modkit if using precompiled version for linux (recommended)
DIR=$INSTALL_DIR/modkit/modkit-0.5.0
mkdir -p $DIR && cd $DIR
tar -xzf modkit*.tar.gz --strip-components=1
