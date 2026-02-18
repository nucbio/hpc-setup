-- ${TOOL_NAME} version ${TOOL_VERSION}

whatis("${TOOL} version ${TOOL_VERSION}")

local root = "$TOOL_PATH"

local bin = pathJoin(root, "bin")
local lib = pathJoin(root, "$LIB")
local include = pathJoin(root, "include")
local pkgconf = pathJoin(root, "$PKG_CONF")

prepend_path("PATH",            bin)
prepend_path("LD_LIBRARY_PATH", lib)
prepend_path("LIBRARY_PATH",    lib)
prepend_path("CPATH",           include)
prepend_path("PKG_CONFIG_PATH", pkgconf)

setenv("CURL_HOME",    root)
setenv("CURL_INCLUDE", include)
setenv("CURL_LIB",     lib)
