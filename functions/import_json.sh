#!/bin/bash

# Import package info from json
#
export REPO_DIR=/home/suvar/gits/templater

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
  PKG_VERSION=$(jq -r --arg p "$PKG_NAME" '.[$p].pkg_version'          "$PKGS_JSON")
  PKG_URL=$(    jq -r --arg p "$PKG_NAME" '.[$p].pkg_url'              "$PKGS_JSON")
  INST_TYPE=$(  jq -r --arg p "$PKG_NAME" '.[$p].inst_type'            "$PKGS_JSON")
  PKGCONF=$(    jq -r --arg p "$PKG_NAME" '.[$p].pkgconf'              "$PKGS_JSON")
  ENABLED=$(    jq -r --arg p "$PKG_NAME" '.[$p].enabled'              "$PKGS_JSON")
  MODULE_HELP=$(       jq -r --arg p "$PKG_NAME" '.[$p].module_help'        "$PKGS_JSON")
  MODULE_DESCRIPTION=$(jq -r --arg p "$PKG_NAME" '.[$p].module_description' "$PKGS_JSON")
  MODULE_CATEGORY=$(   jq -r --arg p "$PKG_NAME" '.[$p].module_category'    "$PKGS_JSON")
  MODULE_URL=$(        jq -r --arg p "$PKG_NAME" '.[$p].module_url'         "$PKGS_JSON")
  MODULE_C_LIB=$(      jq -r --arg p "$PKG_NAME" '.[$p].module_c_lib'       "$PKGS_JSON")

  # Array fields → bash arrays
  mapfile -t INST_OPT      < <(jq -r --arg p "$PKG_NAME" '.[$p].inst_opt[]?'      "$PKGS_JSON")
  mapfile -t DEPENDENCIES  < <(jq -r --arg p "$PKG_NAME" '.[$p].dependencies[]?'  "$PKGS_JSON")
  mapfile -t MODULE_PATH < <(jq -r --arg p "$PKG_NAME" '.[$p].module_path | to_entries[] | "\(.key)|\(.value)"' "$PKGS_JSON")
  mapfile -t MODULE_ENV < <(jq -r --arg p "$PKG_NAME" '.[$p].module_env | to_entries[] | "\(.key)|\(.value)"' "$PKGS_JSON")

  export PKG_NAME PKG_VERSION PKG_URL INST_TYPE PKGCONF ENABLED \
         MODULE_HELP MODULE_DESCRIPTION MODULE_CATEGORY MODULE_URL MODULE_C_LIB \
         INST_OPT DEPENDENCIES MODULE_PATH MODULE_ENV
}
