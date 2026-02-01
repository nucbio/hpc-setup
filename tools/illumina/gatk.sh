#!/bin/bash

# GATK
mkdir -p $INSTALL_DIR/gatk/gatk-4.6.2.0
cd gatk/gatk-4.6.2.0
wget https://github.com/broadinstitute/gatk/releases/download/4.6.2.0/gatk-4.6.2.0.zip
unzip gatk-4.6.2.0.zip
