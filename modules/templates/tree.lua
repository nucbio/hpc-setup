-- ${TOOL} version ${TOOL_VERSION}

help([[Loads the custom ${TOOL} tool]])

whatis("Description: ${TOOL} (custom build)")

-- Points to the specific build output directory
local root = "${TOOL_PATH}"

prepend_path("PATH", root)
