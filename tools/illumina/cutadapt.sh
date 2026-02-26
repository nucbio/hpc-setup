#!/bin/bash

echo "Install Cutadapt"

module load python/$PYTHON_VERSION

pkg_install \
  -n "cutadapt" \
  -v "5.0" \
  -t "venv"

