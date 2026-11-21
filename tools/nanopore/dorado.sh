#!/bin/bash

echo "Install Dorado"

export DORADO_MODELS="$INSTALL_DIR/dorado/models"

PKG_NAME="dorado"
pkg_install \
  -n "$PKG_NAME" \
  -t "unpack"

## Download selected Dorado models

echo "Download selected Dorado Models"

mkdir -p $DORADO_MODELS

module load dorado

if ! command -v dorado &> /dev/null; then
    echo "ERROR: dorado binary not found in PATH after module load."
    exit 1
fi

export DORADO_MODELS=$INSTALL_DIR/dorado/models

for MODEL in \
  dna_r10.4.1_e8.2_400bps_sup@v4.3.0 \
  dna_r10.4.1_e8.2_400bps_sup@v5.0.0 \
  dna_r10.4.1_e8.2_400bps_sup@v5.0.0_6mA@v3 \
  dna_r10.4.1_e8.2_400bps_sup@v5.0.0_5mCG_5hmCG@v3
do
  # Several GB each: download only models that are not there yet
  if [[ -d "$DORADO_MODELS/$MODEL" ]]; then
    echo "[SKIP] Dorado model $MODEL already downloaded"
    continue
  fi
  dorado download \
    --models-directory "$DORADO_MODELS" \
    --model "$MODEL"
done

