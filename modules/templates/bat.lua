-- ${TOOL} version ${TOOL_VERSION}

help([[
${TOOL} - A cat clone with syntax highlighting and Git integration
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: utilities")
whatis("Description: A cat clone with wings - syntax highlighting and Git integration")
whatis("URL: https://github.com/sharkdp/bat")

local root = "${TOOL_PATH}"

-- Add binary to PATH
prepend_path("PATH", root)

-- Set up man pages if they exist
local man_dir = pathJoin(root, "share/man")
if isDir(man_dir) then
    prepend_path("MANPATH", man_dir)
end

conflict("${TOOL}")
