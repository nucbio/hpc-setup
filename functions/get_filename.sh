#!/bin/bash

# Get filename from fullpath
get_filename() {
  local path="$1"
  local filename="${path##*/}"
  echo "${filename%.*}"
}

