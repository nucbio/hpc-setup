#!/bin/bash

module_templater() {
  # Variables
  local lib_dir="${LIB_PATH:-lib}"

  import_json "$1" || exit 1

  local PKGS_JSON="$REPO_DIR/pkgs.json"

  echo $PKG_VERSION
  echo $PKG_URL
  echo $INST_TYPE
  echo $PKGCONF
  cat <<EOF > module.lua
-- ${PKG_NAME} version ${PKG_VERSION}
help([[ ${PKG_NAME} ${PKG_VERSION} - ${MODULE_HELP} ]])

whatis("Name: ${PKG_NAME}")
whatis("Version: ${PKG_VERSION}")
whatis("Category: ${MODULE_CATEGORY}")
whatis("Description: ${MODULE_DESCRIPTION}.")
whatis("URL: ${MODULE_URL}.")

local root = "${PKG_PATH}"
EOF

# Dependency block
if [[ ${#DEPENDENCIES[@]} -gt 0 ]]; then
  cat <<EOF >> module.lua

-- Dependencies
EOF
  for dep in "${DEPENDENCIES[@]}"; do
    local dep_version
    dep_version=$(jq -r --arg d "$dep" '.[$d].pkg_version // ""' "$PKGS_JSON")
    cat <<EOF >> module.lua
load("${dep}/${dep_version}")
EOF
  done
fi

# Append block
if [[ "$MODULE_C_LIB" == "true" ]]; then
  cat <<EOF >> module.lua

-- Libraries
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "${lib_dir}"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "${lib_dir}"))

-- Includes
prepend_path("CPATH",           pathJoin(root, "include"))
prepend_path("LDFLAGS", "-L" ..  pathJoin(root, "${lib_dir}"), " ")
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"), " ")
prepend_path("PKG_CONFIG_PATH",  pathJoin(root, "${PKG_CONF}"))
EOF
fi
# Path block
if [[ ${#MODULE_PATH[@]} -gt 0 ]]; then
  cat <<EOF >> module.lua

-- Module Specific Environment
EOF
  for item in "${MODULE_PATH[@]}"; do
    IFS='|' read -r env_key env_val <<< "$item"
    
    if [[ -z "$env_val" ]]; then
      lua_path="root"
    else
      lua_path="pathJoin(root, \"$env_val\")"
    fi

    cat <<EOF >> module.lua
prepend_path("${env_key}", ${lua_path})
EOF
  done
fi


# Environment block
if [[ ${#MODULE_ENV[@]} -gt 0 ]]; then
  cat <<EOF >> module.lua

-- Module Specific Environment
EOF
  for item in "${MODULE_ENV[@]}"; do
    IFS='|' read -r env_key env_val <<< "$item"
    
    if [[ -z "$env_val" ]]; then
      lua_path="root"
    else
      lua_path="pathJoin(root, \"$env_val\")"
    fi

    cat <<EOF >> module.lua
setenv("${env_key}", ${lua_path})
EOF
  done
fi

# Append block
if [ -d "$MAN" ]; then
  cat <<EOF >> module.lua

-- Man pages
prepend_path("MANPATH", pathJoin(root, "share/man"))
EOF
fi

# Append message
cat <<EOF >> module.lua

-- Message if mode() == "load" then
    LmodMessage("Loading ${PKG_NAME} ${PKG_VERSION}.")
end
EOF

echo "module.lua written for ${PKG_NAME} ${PKG_VERSION}"
}
