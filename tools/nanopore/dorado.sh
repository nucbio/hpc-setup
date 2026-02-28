#!/bin/bash

echo "Install Dorado"

PKG_NAME="dorado"
PKG_VERSION="1.3.1"

pkg_install \
  -n "$PKG_NAME" \
  -v "$PKG_VERSION" \
  -u "https://cdn.oxfordnanoportal.com/software/analysis/dorado-${PKG_VERSION}-linux-x64.tar.gz" \
  -t "unpack"

## Download selected Dorado models

echo "Download selected Dorado Models"

export DORADO_MODELS="$INSTALL_DIR/dorado/models"

mkdir -p $DORADO_MODELS

module load dorado

for MODEL in \
  --model dna_r10.4.1_e8.2_400bps_sup@v4.3.0 \
  --model dna_r10.4.1_e8.2_400bps_sup@v5.0.0 \
  --model dna_r10.4.1_e8.2_400bps_sup@v5.0.0_6mA@v3 \
  --model dna_r10.4.1_e8.2_400bps_sup@v5.0.0_5mCG_5hmCG@v3
do
  dorado download \
    --model-directory "$DORADO_MODELS" \
    --model "$MODEL"
done

