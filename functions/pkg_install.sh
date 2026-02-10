#!/bin/bash

# Universal package intaller

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

    # Derive Archive Name
    local ARCHIVE_NAME="${PKG_URL##*/}"
    local PKG_ARCHIVE="$SOURCES_DIR/$ARCHIVE_NAME"

    # Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
    set_pkg_dirs "$PKG_NAME" "$PKG_VERSION"
    set_build_dir "$PKG_NAME" "$PKG_VERSION"

    # Download & Extract
    wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
    mkdir -p "$PKG_SRC_DIR"
    
    if [[ "$ARCHIVE_NAME" == *.zip ]]; then
        unzip -q "$PKG_ARCHIVE" -d "$PKG_SRC_DIR"
    else
        tar -xf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1
    fi

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
