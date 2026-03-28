#!/bin/bash

# Generate Lmod module files from pkgs.json
# Usage: module_templater "package_name" [optional_tool_path]

module_templater() {
  local PKG_NAME="$1"
  local TOOL_PATH_OVERRIDE="$2"
  local PKGS_JSON="$REPO_DIR/pkgs.json"

  import_json "$PKG_NAME" || return 1

  # Determine output path
  local MODULE_DIR="$INSTALL_DIR/modulefiles/$PKG_NAME"
  local OUTPUT_FILE="$MODULE_DIR/$PKG_VERSION.lua"
  mkdir -p "$MODULE_DIR"

  # Determine TOOL_PATH
  local TOOL_PATH
  if [[ -n "$TOOL_PATH_OVERRIDE" ]]; then
    TOOL_PATH="$TOOL_PATH_OVERRIDE"
  else
    TOOL_PATH="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$PKG_VERSION"
  fi

  # Handle meta-modules
  if [[ "$INST_TYPE" == "meta" ]]; then
    _mt_generate_meta > "$OUTPUT_FILE"
    echo "Module for $PKG_NAME (meta) created."
    return 0
  fi

  # Detect lib/lib64 and pkgconfig paths
  local lib_dir="lib"
  local pkg_conf="lib/pkgconfig"

  if [[ -d "$TOOL_PATH" ]]; then
    local found_lib
    found_lib=$(find "$TOOL_PATH" -maxdepth 1 -type d \( -name "lib" -o -name "lib64" \) -print -quit 2>/dev/null)
    [[ -n "$found_lib" ]] && lib_dir="${found_lib#$TOOL_PATH/}"

    local found_pkgconf
    found_pkgconf=$(find "$TOOL_PATH" -type d -name "pkgconfig" -print -quit 2>/dev/null)
    [[ -n "$found_pkgconf" ]] && pkg_conf="${found_pkgconf#$TOOL_PATH/}"
  fi

  # Detect man directory
  local man_dir=""
  [[ -d "$TOOL_PATH/share/man" ]] && man_dir="share/man"
  [[ -d "$TOOL_PATH/man" ]] && man_dir="man"

  # Version major.minor for {VER_MM} placeholder
  local VER_MM
  VER_MM=$(echo "$PKG_VERSION" | grep -oP '^\d+\.\d+')

  # Generate module file
  {
    _mt_emit_header
    _mt_emit_root
    _mt_emit_conflicts
    _mt_emit_dependencies
    _mt_emit_path_extra
    _mt_emit_c_lib_paths
    _mt_emit_std_flags
    _mt_emit_module_path
    _mt_emit_module_env
    _mt_emit_manpath
    _mt_emit_load_message
  } > "$OUTPUT_FILE"

  echo "Module for $PKG_NAME created."
}

# --- Internal helper functions (all write to stdout) ---

_mt_generate_meta() {
  echo "-- $PKG_NAME"
  echo "whatis(\"$MODULE_DESCRIPTION\")"
  echo ""

  if [[ ${#MODULE_LOADS[@]} -gt 0 ]]; then
    echo "load("
    local last_idx=$(( ${#MODULE_LOADS[@]} - 1 ))
    for i in "${!MODULE_LOADS[@]}"; do
      if [[ $i -eq $last_idx ]]; then
        echo "  \"${MODULE_LOADS[$i]}\""
      else
        echo "  \"${MODULE_LOADS[$i]}\","
      fi
    done
    echo ")"
  fi
}

_mt_emit_header() {
  echo "-- $PKG_NAME version $PKG_VERSION"
  echo "help([[$PKG_NAME $PKG_VERSION - $MODULE_HELP]])"
  echo ""
  echo "whatis(\"Name: $PKG_NAME\")"
  echo "whatis(\"Version: $PKG_VERSION\")"
  [[ -n "$MODULE_CATEGORY" ]] && echo "whatis(\"Category: $MODULE_CATEGORY\")"
  [[ -n "$MODULE_DESCRIPTION" ]] && echo "whatis(\"Description: $MODULE_DESCRIPTION\")"
  [[ -n "$MODULE_URL" ]] && echo "whatis(\"URL: $MODULE_URL\")"
}

_mt_emit_root() {
  echo ""
  echo "local root = \"$TOOL_PATH\""
}

_mt_emit_conflicts() {
  local has_conflicts=false

  if [[ "$MODULE_CONFLICT" == "true" ]]; then
    has_conflicts=true
    echo ""
    echo "conflict(\"$PKG_NAME\")"
  fi

  if [[ ${#MODULE_EXTRA_CONFLICT[@]} -gt 0 ]]; then
    [[ "$has_conflicts" == "false" ]] && echo ""
    for c in "${MODULE_EXTRA_CONFLICT[@]}"; do
      echo "conflict(\"$c\")"
    done
  fi
}

_mt_emit_dependencies() {
  if [[ ${#DEPENDENCIES[@]} -gt 0 ]]; then
    echo ""
    echo "-- Dependencies"
    for dep in "${DEPENDENCIES[@]}"; do
      local dep_version
      dep_version=$(jq -r --arg d "$dep" '.[$d].pkg_version // ""' "$PKGS_JSON")
      echo "load(\"${dep}/${dep_version}\")"
    done
  fi
}

_mt_emit_path_extra() {
  # MODULE_PATH_EXTRA: "bin" | "" (root) | "Linux_x86_64" | "null"/empty (skip)
  # jq returns "null" string for null values, empty for missing
  if [[ "$MODULE_PATH_EXTRA" == "null" ]]; then
    return
  fi

  echo ""
  if [[ -z "$MODULE_PATH_EXTRA" ]]; then
    # Empty string means add root directly to PATH
    echo "prepend_path(\"PATH\", root)"
  else
    echo "prepend_path(\"PATH\", pathJoin(root, \"$MODULE_PATH_EXTRA\"))"
  fi
}

_mt_emit_c_lib_paths() {
  if [[ "$MODULE_C_LIB" != "true" ]]; then
    return
  fi

  echo ""
  echo "-- Libraries"
  echo "prepend_path(\"LD_LIBRARY_PATH\", pathJoin(root, \"$lib_dir\"))"
  echo "prepend_path(\"LIBRARY_PATH\",    pathJoin(root, \"$lib_dir\"))"
  echo ""
  echo "-- Includes"
  echo "prepend_path(\"CPATH\",           pathJoin(root, \"include\"))"
  echo "prepend_path(\"PKG_CONFIG_PATH\", pathJoin(root, \"$pkg_conf\"))"
}

_mt_emit_std_flags() {
  echo ""
  echo "-- Compiler and linker flags"
  echo "prepend_path(\"LDFLAGS\",  \"-L\" .. pathJoin(root, \"$lib_dir\"), \" \")"
  echo "prepend_path(\"CPPFLAGS\", \"-I\" .. pathJoin(root, \"include\"), \" \")"
}

_mt_emit_module_path() {
  if [[ ${#MODULE_PATH[@]} -eq 0 ]]; then
    return
  fi

  echo ""
  echo "-- Additional paths"
  for item in "${MODULE_PATH[@]}"; do
    IFS='|' read -r env_key env_val <<< "$item"

    # Replace placeholders
    env_val="${env_val//\{LIB\}/$lib_dir}"
    env_val="${env_val//\{PKG_CONF\}/$pkg_conf}"
    env_val="${env_val//\{VERSION\}/$PKG_VERSION}"

    # Build lua path expression
    local lua_path
    if [[ -z "$env_val" ]]; then
      lua_path="root"
    else
      lua_path="pathJoin(root, \"$env_val\")"
    fi

    # Special handling for compiler/linker flag keys
    case "$env_key" in
      CFLAGS|CXXFLAGS|CPPFLAGS)
        echo "prepend_path(\"$env_key\", \"-I\" .. $lua_path, \" \")"
        ;;
      LDFLAGS)
        echo "prepend_path(\"$env_key\", \"-L\" .. $lua_path, \" \")"
        ;;
      *)
        echo "prepend_path(\"$env_key\", $lua_path)"
        ;;
    esac
  done
}

_mt_emit_module_env() {
  if [[ ${#MODULE_ENV[@]} -eq 0 ]]; then
    return
  fi

  echo ""
  echo "-- Environment variables"
  for item in "${MODULE_ENV[@]}"; do
    IFS='|' read -r env_key env_val <<< "$item"

    # Replace placeholders
    env_val="${env_val//\{LIB\}/$lib_dir}"
    env_val="${env_val//\{PKG_CONF\}/$pkg_conf}"
    env_val="${env_val//\{VERSION\}/$PKG_VERSION}"
    env_val="${env_val//\{VER_MM\}/$VER_MM}"

    # Build lua expression
    if [[ -z "$env_val" ]]; then
      # Empty value → root
      echo "setenv(\"$env_key\", root)"
    elif [[ "$env_val" == /* ]]; then
      # Absolute path → literal string
      echo "setenv(\"$env_key\", \"$env_val\")"
    elif [[ "$env_val" == *";;" ]]; then
      # Lua package path pattern (e.g., "share/lua/5.4/?.lua;;")
      # Split at ;; — build pathJoin for the path part, append ";;"
      local path_part="${env_val%%;;}"
      # Split into directory and filename parts for pathJoin
      local dir_part="${path_part%/*}"
      local file_part="${path_part##*/}"
      echo "setenv(\"$env_key\", pathJoin(root, \"$dir_part\", \"$file_part\") .. \";;\")"
    else
      echo "setenv(\"$env_key\", pathJoin(root, \"$env_val\"))"
    fi
  done
}

_mt_emit_manpath() {
  if [[ -n "$man_dir" ]]; then
    echo ""
    echo "-- Man pages"
    echo "prepend_path(\"MANPATH\", pathJoin(root, \"$man_dir\"))"
  fi
}

_mt_emit_load_message() {
  echo ""
  echo "if mode() == \"load\" then"
  echo "    LmodMessage(\"Loading $PKG_NAME $PKG_VERSION.\")"
  echo "end"
}
