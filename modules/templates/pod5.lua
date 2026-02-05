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
load("python3/${PYTHON_VERSION}")

if mode() == "load" then
    LmodMessage("pod5 ${TOOL_VERSION} loaded (using Python ${PYTHON_VERSION}).")
end
