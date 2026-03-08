-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - High-speed nanopore data format utilities.

This module is a wrapper for the pod5 Python package.
It requires Python ${PYTHON_VERSION} to be loaded.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Description: Tools for writing and reading Oxford Nanopore POD5 files.")

-- Load Python
load("python/${PYTHON_VERSION}")

local root = "$TOOL_PATH"

prepend_path("PATH", pathJoin(root, "bin"))
-- Version conflicts
conflict("$TOOL")

if mode() == "load" then
    LmodMessage("Loading ${TOOL} ${TOOL_VERSION}.")
end

