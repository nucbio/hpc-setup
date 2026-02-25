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

local root = "${TOOL_PATH}"
local python_lib = "$INSTALL_DIR/python/python-$PYTHON_VERSION/lib"

-- Add the cutadapt CLI binary to the path 
prepend_path("PATH", pathJoin(root, "bin"))
prepend_path("LD_LIBRARY_PATH", python_lib)

-- Version conflicts
conflict("$TOOL")

if mode() == "load" then
    LmodMessage("${TOOL} ${TOOL_VERSION} loaded (using Python ${PYTHON_VERSION}).")
end

