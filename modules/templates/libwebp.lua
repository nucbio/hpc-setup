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

-- library directory (lib64)
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))

-- Build helper flags
setenv("CPPFLAGS", "-I" .. pathJoin(root, "include"))
setenv("LDFLAGS",  "-L" .. pathJoin(root, "lib"))

-- pkg-config files
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib", "pkgconfig"))

-- CMake config files
prepend_path("CMAKE_PREFIX_PATH", root)

