#!/bin/bash

echo "Install Cutadapt"

module load python/$PYTHON_VERSION

pkg_install \
  -n "cutadapt" \
  -t "venv"

