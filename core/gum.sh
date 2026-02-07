#!/bin/bash

#!/bin/bash

# Configuration
GUM_VERSION="0.17.0"
GUM_BIN="$INSTALL_DIR/gum"

# Architecture detection (Auto-detects x86_64 or arm64)
ARCH=$(uname -m)
if [ "$ARCH" = "aarch64" ]; then ARCH="arm64"; fi 

# Construction
TARBALL="gum_${GUM_VERSION}_Linux_${ARCH}.tar.gz"
URL="https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/${TARBALL}"

echo "Downloading Gum $GUM_VERSION for $ARCH..."

cd /tmp || exit

# Download and Extract
wget -q "$URL" -O gum.tar.gz

# Extracting without needing to know the internal folder name
mkdir -p gum_temp
tar -xzf gum.tar.gz -C gum_temp --strip-components=1

# Install the binary
# Using find ensures we grab the binary even if the folder structure changes
install -m 0755 gum_temp/gum "$GUM_BIN"

# Cleanup
rm -rf gum.tar.gz gum_temp
echo "Installed gum to $GUM_BIN"

