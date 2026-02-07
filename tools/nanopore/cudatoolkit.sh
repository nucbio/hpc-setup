#!/bin/bash

echo "Install CUDA"

# Variables
TOOL_NAME="cuda"
export CUDA_VERSION="13.1.1"
export DRIVER_VERSION="580.95.05"
SOURCE_URL="https://developer.download.nvidia.com/compute/cuda/${CUDA_VERSION}/local_installers/cuda_${CUDA_VERSION}_${DRIVER_VERSION}_linux.run"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$CUDA_VERSION"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"

# 1. Prepare Environment
mkdir -p "$SOURCE_ARCHIVE"
rm -rf /tmp/$TOOL_NAME-build
mkdir -p /tmp/$TOOL_NAME-build
cd /tmp/$TOOL_NAME-build

# 2. Download and Archive
wget -q "$SOURCE_URL" -O "${TOOL_NAME}_${CUDA_VERSION}_linux.run"
cp "${TOOL_NAME}_${CUDA_VERSION}_linux.run" "$SOURCE_ARCHIVE/"

# 3. Build and Install
# Using the .run installer with silent flags
sh "${TOOL_NAME}_${CUDA_VERSION}_linux.run" \
    --silent \
    --override \
    --toolkit \
    --toolkitpath="$TARGET_DIR" \
    --no-opengl-libs \
    --no-drm \
    --no-man-page

# 4. Cleanup Build Area
rm -rf /tmp/$TOOL_NAME-build

# 5. Module generation
make_lua_module "cuda" "$CUDA_VERSION"
