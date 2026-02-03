-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} - A modern replacement for ls
Version: ${TOOL_VERSION}

${TOOL} is a modern, maintained replacement for ls with improved features,
better defaults, and more colors.

For more information, visit: https://github.com/eza-community/eza
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: file utilities")
whatis("Description: A modern replacement for ls")
whatis("URL: https://github.com/eza-community/eza")

local base = "${TOOL_PATH}"

-- Add binary directory to PATH
prepend_path("PATH", base)
