-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - is installed as pip in python3.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")

-- Dependencies
load("python3/${PYTHON_VERSION}")

local root = "$INSTALL_DIR/python/python-${PYTHON_VERSION}"

-- Add the cutadapt CLI binary to the path 
prepend_path("PATH", pathJoin(root, "bin"))

-- Version conflicts
conflict("$TOOL")

-- Message
if mode() == "load" then
    LmodMessage("${TOOL} ${TOOL_VERSION} loaded using Python ${PYTHON_VERSION}.")
end
