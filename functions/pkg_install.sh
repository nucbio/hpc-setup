#!/bin/bash

# Universal package intaller
# Options:
# -n   Package name
# -v   Package version
# -u   Package URL (accepted arhives: tar.gz, tar.xz, tar.bz2, .zip (unpack only)
# -o   Configuration options (followed by prefix)
# -t   Installation type: "config", "cmake", "meson", "unpack" (no intallation), 
#      "venv" for python packages.

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
  
  # Python environments
  if [[ "$PKG_TYPE" == "venv" ]]; then
    if ! command -v python &> /dev/null; then
      echo "Python not found. Please load python: 'module load python'."
      return 1
    fi
    PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION"
    mkdir -p "$PKG_PREFIX"
    
    python -m venv "$PKG_PREFIX"
    "$PKG_PREFIX/bin/pip" install --upgrade pip
    "$PKG_PREFIX/bin/pip" install "${PKG_NAME}==${PKG_VERSION}"
    make_lua_module $PKG_NAME $PKG_VERSION
    return 0
  fi

  # Derive Archive Name
  local ARCHIVE_NAME="${PKG_URL##*/}"
  local PKG_ARCHIVE="$SOURCES_DIR/$ARCHIVE_NAME"
  
  
  # Download & Extract
  if wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"; then
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

    if [[ "$ARCHIVE_NAME" == *.zip ]]; then
      PKG_TMP="$PKG_PREFIX/_tmp_$$"
      mkdir -p "$PKG_TMP"
      unzip -q "$PKG_ARCHIVE" -d "$PKG_TMP"
      
      # Find the internal directory
      INTERNAL_DIR=$(find "$PKG_TMP" -mindepth 1 -maxdepth 1 -type d | head -n 1)
      
      if [[ -n "$INTERNAL_DIR" ]]; then
        # Enable dotglob so hidden files (dotfiles) are moved too
        shopt -s dotglob
        mv "$INTERNAL_DIR"/* "$PKG_PREFIX/"
        shopt -u dotglob
      fi
      
      rm -rf "$PKG_TMP"
      
      make_lua_module "$PKG_NAME" "$PKG_VERSION"
      return 0
    else
      # Unpack other archives: tar.gz, tar.bz2, tar.xz
      tar -xf "$PKG_ARCHIVE" -C "$PKG_PREFIX" --strip-components=1
      make_lua_module "$PKG_NAME" "$PKG_VERSION"
      return 0
    fi
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
      make -j $(nproc) && make install
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
      meson setup "$PKG_BUILD_DIR" "$PKG_SRC_DIR" \
        --prefix="$PKG_PREFIX" \
        $EXTRA_OPTS
        meson compile -C "$PKG_BUILD_DIR" -j $(nproc)
        meson install -C "$PKG_BUILD_DIR"
    ;;
  esac

    # Finalize
    cd "$REPO_DIR"
    rm -rf "$PKG_BUILD_DIR"
    make_lua_module "$PKG_NAME" "$PKG_VERSION"
}
