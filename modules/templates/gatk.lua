-- ${TOOL} version ${TOOL_VERSION}

whatis("Name: GATK")
whatis("Version: $TOOL_VERSION")
whatis("Description: A comprehensive suite of tools for variant discovery and genotyping.")
whatis("Category: Bioinformatics")

local root = "$TOOL_PATH"

prepend_path("PATH", pathJoin(root, "gatk-$TOOL_VERSION"))
