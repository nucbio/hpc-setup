#!/bin/bash

PKG_NAME="zlib"

import_json $PKG_NAME

echo "$PKG_NAME"
echo "$PKG_VERSION"
echo "$PKG_URL"
echo "$INST_TYPE"
echo "$INST_OPT"
echo "$PKGCONF"
echo "$ENABLED"

echo "Dependencies:"
for dep in "${DEPENDENCIES[@]}"; do
    echo "$dep"
done
