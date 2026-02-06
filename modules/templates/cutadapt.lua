-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - Finds and removes adapter sequences, primers, poly-A tails and 
other types of unwanted sequence from your high-throughput sequencing reads.

This module is a wrapper for the cutadapt Python package.
It requires Python ${PYTHON_VERSION} to be loaded.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Bioinformatics/Sequence Preprocessing")
whatis("Description: Trim adapters and clean up high-throughput sequencing reads.")
whatis("URL: https://cutadapt.readthedocs.io/")

----------------------------------------------------------------------
-- Specificity: Enforce the Python dependency
----------------------------------------------------------------------
-- Load the specific version of Python this was installed into
load("python3/${PYTHON_VERSION}")

-- Define the root based on the Python installation path
local python_root = "$INSTALL_DIR/python/python-${PYTHON_VERSION}"

-- Add the cutadapt CLI binary to the path 
-- (Installed by pip into the Python bin directory)
prepend_path("PATH", pathJoin(python_root, "bin"))

conflict("${TOOL}")

if mode() == "load" then
    LmodMessage("cutadapt ${TOOL_VERSION} loaded (using Python ${PYTHON_VERSION}).")
end
