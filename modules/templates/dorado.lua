-- ${TOOL} version ${TOOL_VERSION}
local version = "${TOOL_VERSION}"
local base = "${TOOL_PATH}"

whatis("${TOOL} " .. version)

help([[Loads ${TOOL} ]] .. version .. [[ environment.

Binary directory added to PATH.
Library directory added to LD_LIBRARY_PATH.
]])

-- Standard paths
prepend_path("PATH",            pathJoin(base, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(base, "$LIB"))

-- Environment variables
setenv("${TOOL^^}_HOME", base)

-- Path for Dorado models 
setenv("DORADO_MODELS", "/projects/p_bp/tools/dorado/dorado_models")
