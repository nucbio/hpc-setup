#!/bin/bash

module_templater() {
  # Variables
  local lib_dir="${LIB_PATH:-lib}"

  cat <<EOF > module.lua
-- ${PKG_NAME} version ${PKG_VERSION}
help([[ ${PKG_NAME} ${PKG_VERSION} - ${module_help} ]])

whatis("Name: ${PKG_NAME}")
whatis("Version: ${PKG_VERSION}")
whatis("Category: ${module_category}")
whatis("Description: ${module_description}.")
whatis("URL: ${module_url}.")

local root = "${PKG_PATH}"
EOF

    # Append block
    if [ -d "$C_LIBS" ]; then
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

# Append block
if [ -d "$MAN" ]; then
  cat <<EOF >> module.lua
-- Man pages
prepend_path("MANPATH", pathJoin(root, "share/man"))
EOF
fi

# Append message
cat <<EOF >> module.lua
-- Message
if mode() == "load" then
    LmodMessage("Loading ${PKG_NAME} ${PKG_VERSION}.")
end
EOF
}

