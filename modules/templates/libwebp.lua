-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION}
WebP image codec library
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Description: WebP image codec library (encode/decode).")

local root = "${TOOL_PATH}"

prepend_path("PATH", pathJoin(root, "bin"))

-- include directory
prepend_path("CPATH", pathJoin(root, "include"))

-- library directory
prepend_path("LIBRARY_PATH",    pathJoin(root, "$LIB"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))

-- Build helper flags
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"), " ")
prepend_path("LDFLAGS",  "-L" .. pathJoin(root, "$LIB"), " ")

-- pkg-config files
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "$PKG_CONF"))

-- CMake config files
prepend_path("CMAKE_PREFIX_PATH", root)

