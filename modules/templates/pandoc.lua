-- ${TOOL} version ${TOOL_VERSION}

help([[
${TOOL} ${TOOL_VERSION}
]])

whatis("Description: Pandoc universal document converter")
whatis("Version: ${TOOL_VERSION}")
whatis("URL: https://pandoc.org")

local root = "${TOOL_PATH}"

-- Add binaries to path
prepend_path("PATH", pathJoin(root, "bin"))

-- Set PANDOC_DIR for reference by other scripts
setenv("PANDOC_DIR", root)

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
