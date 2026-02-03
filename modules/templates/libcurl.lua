-- ${TOOL_NAME} version ${TOOL_VERSION}

whatis("${TOOL} version ${TOOL_VERSION}")

local root = "${TOOL_PATH}"

prepend_path("PATH",            pathJoin(root, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib"))
prepend_path("CPATH",           pathJoin(root, "include"))
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/pkgconfig"))

setenv("CURL_HOME",    root)
setenv("CURL_INCLUDE", pathJoin(root, "include"))
setenv("CURL_LIB",     pathJoin(root, "lib"))
