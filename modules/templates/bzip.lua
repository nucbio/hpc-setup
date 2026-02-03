-- ${TOOL} version ${TOOL_VERSION}
whatis("${TOOL} version ${TOOL_VERSION}")

local root = "${TOOL_PATH}"

-- Binaries
prepend_path("PATH", pathJoin(root, "bin"))

-- Compiler flags (APPEND using space separator)
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"), " ")
prepend_path("LDFLAGS",  "-L" .. pathJoin(root, "lib64"), " ")

-- Library paths
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib64"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib64"))
