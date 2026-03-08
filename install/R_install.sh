#!/bin/bash

## Newest R
export R_VERSION="4.5.2"

source $REPO_DIR/R/R.sh

module load R/$R_VERSION
Rscript $REPO_DIR/R/R_libraries.R

## R version for Rserver
export R_VERSION="4.2.1"

source $REPO_DIR/R/R.sh

module load R/$R_VERSION
Rscript $REPO_DIR/R/R_libraries.R
