-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION}
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")

-- Installation prefix
local root = "$TOOL_PATH"

-- Paths
local bin        = pathJoin(root, "bin")
local lib        = pathJoin(root, "$LIB")
local include    = pathJoin(root, "include")

-- Environment setup
prepend_path("PATH",            bin)
prepend_path("LD_LIBRARY_PATH", lib)
prepend_path("LIBRARY_PATH",    lib)
prepend_path("C_INCLUDE_PATH",  include)

-- Version conflicts
conflict("$TOOL")

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
