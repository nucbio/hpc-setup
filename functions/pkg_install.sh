#!/bin/bash

# Universal package intaller
# Options:
# -n   Package name (key in pkgs.json)
# -v   Package version: default is pkg_version from pkgs.json. Only give it to
#      override the json (e.g. R_VERSION); the module then uses this version.
# -u   Package URL: default is pkg_url from pkgs.json (with the version replaced
#      when -v overrides it). Accepted archives: tar.gz, tar.xz, tar.bz2, .zip (unpack only)
# -o   Configuration options (followed by prefix)
# -t   Installation pattern type: 
#          "conf" - configure -> make -> make intall (Default), 
#          "make"   - make (without configure and make intall),
#          "cmake"  - cmake -> cmake --build -> cmake --install, 
#          "meson"  - meson setup -> compile -> install, 
#          "unpack" - unpack precompiled package (zip, tar.gz, tar.xz, tar.bz2), 
#          "venv"   - python environment (pip python packages). 

pkg_install() {
  # Reset the global index for getopts
  local OPTIND=1
    
  local PKG_NAME PKG_VERSION PKG_URL PKG_TYPE="conf" EXTRA_OPTS=""
  
  # Parse Arguments
  # n: Name, v: Version, u: URL, t: Type, o: Options (the string you requested)
  while getopts "n:v:u:t:o:" opt; do
    case $opt in
      n) PKG_NAME="$OPTARG" ;;
      v) PKG_VERSION="$OPTARG" ;;
      u) PKG_URL="$OPTARG" ;;
      t) PKG_TYPE="$OPTARG" ;; 
      o) EXTRA_OPTS="$OPTARG" ;; # configuraiton options
      *) echo "Usage: pkg_install -n name -v ver -u url [-t type] [-o 'options']"; return 1 ;;
    esac
  done
  
  # Shift away the parsed options so $@ contains remaining args (if any)
  shift $((OPTIND-1))

  # Version and URL come from pkgs.json
  local JSON_VERSION JSON_URL=""
  JSON_VERSION=$(pkg_version "$PKG_NAME") || return 1
  if [[ "$PKG_TYPE" != "venv" ]]; then
    JSON_URL=$(pkg_url "$PKG_NAME") || return 1
  fi

  if [[ -z "$PKG_VERSION" ]]; then
    PKG_VERSION="$JSON_VERSION"
  elif [[ "$PKG_VERSION" != "$JSON_VERSION" ]]; then
    echo "WARNING: $PKG_NAME $PKG_VERSION overrides pkgs.json version $JSON_VERSION."
  fi

  if [[ -z "$PKG_URL" && "$PKG_TYPE" != "venv" ]]; then
    PKG_URL="${JSON_URL//$JSON_VERSION/$PKG_VERSION}"
  fi

  # Already installed by a previous run (see functions/stamp.sh)?
  # Otherwise remove leftovers of a failed attempt.
  if skip_if_installed "$PKG_NAME" "$PKG_VERSION"; then
    return 0
  fi

  # Python environments
  if [[ "$PKG_TYPE" == "venv" ]]; then
    if ! command -v python3 &> /dev/null; then
      echo "Python not found. Please load python: 'module load python'."
      return 1
    fi
    PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION"
    mkdir -p "$PKG_PREFIX"
    
    python3 -m venv "$PKG_PREFIX"
    "$PKG_PREFIX/bin/pip" install --upgrade pip
    "$PKG_PREFIX/bin/pip" install "${PKG_NAME}==${PKG_VERSION}" || return 1

    module_templater "$PKG_NAME" "" "$PKG_VERSION" || return 1
    return 0
  fi

  # Derive Archive Name
  local ARCHIVE_NAME="${PKG_URL##*/}"
  local PKG_ARCHIVE="$SOURCES_DIR/$ARCHIVE_NAME"
  
  
  # Download & Extract
  echo "Downloading $PKG_NAME..."
  if wget -nv -c \
          --tries=10 \
          --read-timeout=30 \
          --waitretry=5 \
          "$PKG_URL" -O "$PKG_ARCHIVE"; then
    echo "Downloaded $ARCHIVE_NAME"
  else
    echo "ERROR: Failed to download $PKG_NAME."
    echo "Check if the URL is valid: $PKG_URL"
    return 1
  fi

  # unpack zip
  if [[ "$PKG_TYPE" == "unpack" ]]; then
    PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION"
    mkdir -p $PKG_PREFIX

    PKG_TMP="$PKG_PREFIX/_tmp_$$"
    mkdir -p "$PKG_TMP"
    if [[ "$ARCHIVE_NAME" == *.zip ]]; then
      unzip -q "$PKG_ARCHIVE" -d "$PKG_TMP"
    else
      # tar.gz, tar.bz2, tar.xz
      tar -xf "$PKG_ARCHIVE" -C "$PKG_TMP"
    fi

    # Archives with one top folder: move its content up.
    # Archives with loose files (e.g. a single binary): move them as they are.
    # dotglob/nullglob: include hidden files, empty glob gives an empty list
    local OLD_SHOPT
    OLD_SHOPT=$(shopt -p dotglob nullglob || true)  # status 1 if an option is off
    shopt -s dotglob nullglob
    local TOP_ENTRIES=("$PKG_TMP"/*)
    local CONTENT_DIR="$PKG_TMP"
    if [[ ${#TOP_ENTRIES[@]} -eq 1 && -d "${TOP_ENTRIES[0]}" ]]; then
      CONTENT_DIR="${TOP_ENTRIES[0]}"
    fi
    local CONTENT=("$CONTENT_DIR"/*)
    [[ ${#CONTENT[@]} -gt 0 ]] && mv "${CONTENT[@]}" "$PKG_PREFIX/"
    eval "$OLD_SHOPT"
    rm -rf "$PKG_TMP"

    module_templater "$PKG_NAME" "" "$PKG_VERSION" || return 1
    return 0
  fi
  
  # Continue compilations
  # Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
  set_pkg_dirs "$PKG_NAME" "$PKG_VERSION"
  set_build_dir "$PKG_NAME" "$PKG_VERSION"

  tar -xf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

  cd "$PKG_BUILD_DIR" || return
  
  # Execute Build based on Type
  case "$PKG_TYPE" in
    conf)
      "$PKG_SRC_DIR/configure" --prefix="$PKG_PREFIX" $EXTRA_OPTS
      # Separate lines: in an && list a failing make does not stop set -e
      make -j $(nproc)
      make install
    ;;
    cmake)
      cmake -S "$PKG_SRC_DIR" \
            -B "$PKG_BUILD_DIR" \
            -DCMAKE_INSTALL_PREFIX="$PKG_PREFIX" \
            $EXTRA_OPTS
      cmake --build   "$PKG_BUILD_DIR" -j$(nproc)
      cmake --install "$PKG_BUILD_DIR"
    ;;
    meson)
      # --libdir=lib: not lib/x86_64-linux-gnu (Debian multiarch default),
      # which module_templater does not detect
      meson setup "$PKG_BUILD_DIR" "$PKG_SRC_DIR" \
        --prefix="$PKG_PREFIX" \
        --libdir=lib \
        $EXTRA_OPTS
        meson compile -C "$PKG_BUILD_DIR" -j $(nproc)
        meson install -C "$PKG_BUILD_DIR"
    ;;
  esac

    # Finalize
    cd "$REPO_DIR"
    rm -rf "$PKG_BUILD_DIR"
    module_templater "$PKG_NAME" "" "$PKG_VERSION"
}
