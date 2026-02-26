-- ${TOOL} version ${TOOL_VERSION}

whatis("Name: $TOOL")
whatis("Version: $TOOL_VERSION")
whatis("Description: A comprehensive suite of tools for variant discovery and genotyping.")
whatis("Category: Bioinformatics")

local root = "$TOOL_PATH"

prepend_path("PATH", root)

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
