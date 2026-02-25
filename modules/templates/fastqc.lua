-- ${TOOL} version ${TOOL_VERSION}

whatis("Name: FastQC")
whatis("Version: $TOOL_VERSION")
whatis("Description: A quality control tool for high throughput sequence data.")
whatis("Category: Bioinformatics")

local root = "$TOOL_PATH"

prepend_path("PATH", pathJoin(root, "FastQC"))
