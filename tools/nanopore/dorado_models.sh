#!/bin/bash

# Download selected Dorado models

DORADO_MODELS="$INSTALL_DIR/dorado/models"

mkdir -p $DORADO_MODELS

module load dorado

dorado download \
    --directory $DORADO_MODELS \
    --model dna_r10.4.1_e8.2_400bps_sup@v4.3.0 \
    --model dna_r10.4.1_e8.2_400bps_sup@v5.0.0 \
    --model dna_r10.4.1_e8.2_400bps_sup@v5.0.0_6mA@v3 \
    --model dna_r10.4.1_e8.2_400bps_sup@v5.0.0_5mCG_5hmCG@v3

