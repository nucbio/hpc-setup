#!/bin/bash

# Import package info from json

import_json() {
    local pkg="$1"
    local json="$REPO_DIR/pkgs.json"

    export PKG_NAME="$pkg"
    export PKG_VERSION=$(jq -r --arg pkg "$pkg" '.[$pkg].pkg_version // ""' "$json")
    export PKG_URL=$(jq -r --arg pkg "$pkg" '.[$pkg].pkg_url // ""' "$json")
    export INST_TYPE=$(jq -r --arg pkg "$pkg" '.[$pkg].inst_type // ""' "$json")
    export INST_OPT=$(jq -r --arg pkg "$pkg" '.[$pkg].inst_opt // ""' "$json")
    export PKGCONF=$(jq -r --arg pkg "$pkg" '.[$pkg].pkgconf // ""' "$json")
    export ENABLED=$(jq -r --arg pkg "$pkg" '.[$pkg].enabled // false' "$json")

    mapfile -t DEPENDENCIES < <(
        jq -r --arg pkg "$pkg" '.[$pkg].dependencies // [] | .[]' "$json"
    )
}

