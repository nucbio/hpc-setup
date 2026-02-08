#!/bin/bash

# Standardizing the Source and Installation Prefix Paths
# Usage: set_pkg_dirs "bzip2" "1.0.8"
set_pkg_dirs() {
    local name="$1"
    local version="$2"
    
    if [[ -z "$INSTALL_DIR" ]]; then
        echo "Error: INSTALL_DIR is not defined." >&2
        return 1
    fi

    if [[ -z "$name" || -z "$version" ]]; then
        echo "Error: set_build_dir requires PKG_NAME and PKG_VERSION arguments." >&2
        return 1
    fi

    export PKG_PREFIX="${INSTALL_DIR}/${name}/${name}-${version}"
    export PKG_SRC_DIR="${PKG_PREFIX}/src"

    mkdir -p "$PKG_SRC_DIR"
}

# Standardizing the Build Directory Path
# Usage: set_build_dir "nginx" "1.25.3"
set_build_dir() {
    local name="$1"
    local version="$2"

    if [[ -z "$BUILD_BASE" ]]; then
        echo "Error: BUILD_BASE is not defined." >&2
        return 1
    fi

    if [[ -z "$name" || -z "$version" ]]; then
        echo "Error: set_build_dir requires PKG_NAME and PKG_VERSION arguments." >&2
        return 1
    fi

    export PKG_BUILD_DIR="${BUILD_BASE}/${name}/${name}-${version}/build-$$"
    rm -rf   "$PKG_BUILD_DIR"
    mkdir -p "$PKG_BUILD_DIR"
}
