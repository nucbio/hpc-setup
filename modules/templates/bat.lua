-- ${TOOL} version ${TOOL_VERSION}

help([[
${TOOL} - A cat clone with syntax highlighting and Git integration
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: CLI tools")
whatis("Description: A new cat - syntax highlighting and Git integration")
whatis("URL: https://github.com/sharkdp/bat")

local root = "${TOOL_PATH}"
local man = pathJoin(root, "share/man")


prepend_path("PATH", root)
prepend_path("MANPATH", man)

conflict("${TOOL}")
