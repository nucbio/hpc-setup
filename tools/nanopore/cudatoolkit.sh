#!/bin/bash

mkdir -p $INSTALL_DIR
cd $INSTALL_DIR
wget https://developer.download.nvidia.com/compute/cuda/13.0.2/local_installers/cuda_13.0.2_580.95.05_linux.run
sh cuda_13.0.2_580.95.05_linux.run \
  --toolkit \
  --toolkitpath=$INSTALL_DIR \
  --no-opengl-libs \
  --no-drm \
  --no-man-page
