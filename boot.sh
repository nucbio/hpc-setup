#!/bin/bash

set -e

echo "HPC installation into a single directory"

export INSTALL_DIR=$(pwd)

# Validate installation directory
check_dir() {
    # 1. Check if INSTALL_DIR is the Home directory
    if [ "$INSTALL_DIR" == "$HOME" ]; then
        echo "Error: Installation cannot be run directly in the Home directory."
        return 1
    fi

    # 2. Check if INSTALL_DIR is the Root directory (extremely dangerous)
    if [ "$INSTALL_DIR" == "/" ]; then
        echo "Error: Installation cannot be run in the root (/) directory."
        return 1
    fi

    # 3. Check for specific system directories (optional but recommended)
    if [[ "$INSTALL_DIR" =~ ^/(bin|boot|dev|etc|lib|lib64|root|sys|proc|sbin|usr/bin|usr/sbin|opt/system)$ ]]; then
        echo "Error: Installation detected in a protected system directory: $INSTALL_DIR"
        return 1
    fi

    # 4. Check write permissions
    if [ ! -w "$INSTALL_DIR" ]; then
        echo "Error: No write permission for directory: $INSTALL_DIR"
        return 1 
    fi
    # 5. Check if directory is not empty
    if [ -d "$INSTALL_DIR" ] && [ "$(ls -A "$INSTALL_DIR" 2>/dev/null)" ]; then
        echo "WARNING: Installation directory is not empty: $INSTALL_DIR"
        echo "Existing files may be overwritten or cause conflicts."
        echo "Consider using an empty directory for a clean installation."
    fi

    echo "Environment check passed. Proceeding in: $INSTALL_DIR"
}
check_dir || return

# Check if wget is available to download tools
check_tools() {
    if ! command -v wget &> /dev/null; then
        echo "wget is not available on this system"
        return 1 
    fi
    
    if ! command -v unzip &> /dev/null; then
        echo "Error: unzip is not available on this system"
        return 1
    fi
    echo "Required tools available, continuing with script..."
}

echo "Check if wget is available..."
check_wget || return

echo "Downloading repository with wget..."
REPO="https://github.com/nucbio/hpc-setup/archive/refs/heads/main.zip"
export REPO_DIR="$INSTALL_DIR/hpc-setup"
wget "$REPO" -O "$INSTALL_DIR/hpc-setup.zip"
unzip -q "$INSTALL_DIR/hpc-setup.zip" -d "$INSTALL_DIR"
rm "$INSTALL_DIR/hpc-setup.zip"

echo "Installation starting..."
source "$REPO_DIR/install.sh"

