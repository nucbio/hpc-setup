-- ${TOOL} version ${TOOL_VERSION}
local version = "${TOOL_VERSION}"
local root = "${TOOL_PATH}"

whatis("${TOOL} " .. version)

help([[Loads ${TOOL} ]] .. version .. [[ environment.

Binary directory added to PATH.
Library directory added to LD_LIBRARY_PATH.
]])

-- Standard paths
prepend_path("PATH",            pathJoin(root, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))

-- Path for Dorado models 
setenv("DORADO_MODELS", "$DORADO_MODELS")

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
