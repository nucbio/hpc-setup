-- ${TOOL} version ${TOOL_VERSION}
whatis("${TOOL} version ${TOOL_VERSION}")

local root = "${TOOL_PATH}"

prepend_path("PATH", pathJoin(root, "bin"))

-- Public include directory
prepend_path("CPATH", pathJoin(root, "include"))
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"), " ")

-- Library paths
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib64"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib64"))
prepend_path("LDFLAGS", "-L" .. pathJoin(root, "lib64"), " ")

-- pkg-config
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib64/pkgconfig"))
