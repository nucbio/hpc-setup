#!/bin/bash

# Import package info from json

import_json() {
  local PKG_NAME="$1"
  local PKGS_JSON="$REPO_DIR/pkgs.json"

  # Check package exists
  local exists
  exists=$(jq -r --arg p "$PKG_NAME" 'has($p)' "$PKGS_JSON")
  if [[ "$exists" != "true" ]]; then
    echo "ERROR: Package '$PKG_NAME' not found in $PKGS_JSON" >&2
    return 1
  fi

  # Scalar fields
  PKG_VERSION=$(jq -r --arg p "$PKG_NAME" '.[$p].pkg_version // empty'          "$PKGS_JSON")
  PKG_URL=$(    jq -r --arg p "$PKG_NAME" '.[$p].pkg_url // empty'              "$PKGS_JSON")
  INST_TYPE=$(  jq -r --arg p "$PKG_NAME" '.[$p].inst_type // empty'            "$PKGS_JSON")
  PKGCONF=$(    jq -r --arg p "$PKG_NAME" '.[$p].pkgconf // empty'              "$PKGS_JSON")
  ENABLED=$(    jq -r --arg p "$PKG_NAME" '.[$p].enabled // empty'              "$PKGS_JSON")

  # Module scalar fields
  MODULE_HELP=$(        jq -r --arg p "$PKG_NAME" '.[$p].module_help // empty'        "$PKGS_JSON")
  MODULE_DESCRIPTION=$( jq -r --arg p "$PKG_NAME" '.[$p].module_description // empty' "$PKGS_JSON")
  MODULE_CATEGORY=$(    jq -r --arg p "$PKG_NAME" '.[$p].module_category // empty'    "$PKGS_JSON")
  MODULE_URL=$(         jq -r --arg p "$PKG_NAME" '.[$p].module_url // empty'         "$PKGS_JSON")
  MODULE_C_LIB=$(       jq -r --arg p "$PKG_NAME" '.[$p].module_c_lib // empty'       "$PKGS_JSON")
  # Use "null" sentinel for null/missing, preserve empty string ""
  MODULE_PATH_EXTRA=$(jq -r --arg p "$PKG_NAME" '.[$p].module_path_extra // "null"' "$PKGS_JSON")
  MODULE_CONFLICT=$(    jq -r --arg p "$PKG_NAME" '.[$p].module_conflict // "false"'  "$PKGS_JSON")

  # Array fields → bash arrays
  mapfile -t INST_OPT      < <(jq -r --arg p "$PKG_NAME" '.[$p].inst_opt[]?'      "$PKGS_JSON")
  mapfile -t DEPENDENCIES  < <(jq -r --arg p "$PKG_NAME" '.[$p].dependencies[]?'  "$PKGS_JSON")

  # module_path: handle both string and array values per key
  mapfile -t MODULE_PATH < <(jq -r --arg p "$PKG_NAME" '
    .[$p].module_path // {} | to_entries[] |
    if (.value | type) == "array" then
      .key as $k | .value[] | "\($k)|\(.)"
    else
      "\(.key)|\(.value)"
    end' "$PKGS_JSON")

  # module_env: key|value pairs
  mapfile -t MODULE_ENV < <(jq -r --arg p "$PKG_NAME" '
    .[$p].module_env // {} | to_entries[] | "\(.key)|\(.value)"' "$PKGS_JSON")

  # Extra conflict declarations (e.g., java has ["jdk"])
  mapfile -t MODULE_EXTRA_CONFLICT < <(jq -r --arg p "$PKG_NAME" '.[$p].module_extra_conflict[]?' "$PKGS_JSON")

  # Meta-module loads (ordered package names, no versions)
  mapfile -t MODULE_LOADS < <(jq -r --arg p "$PKG_NAME" '.[$p].module_loads[]?' "$PKGS_JSON")

  export PKG_NAME PKG_VERSION PKG_URL INST_TYPE PKGCONF ENABLED \
         MODULE_HELP MODULE_DESCRIPTION MODULE_CATEGORY MODULE_URL MODULE_C_LIB \
         MODULE_PATH_EXTRA MODULE_CONFLICT \
         INST_OPT DEPENDENCIES MODULE_PATH MODULE_ENV MODULE_EXTRA_CONFLICT MODULE_LOADS
}
