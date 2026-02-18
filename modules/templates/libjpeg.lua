-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION}
High-performance JPEG codec.
This module sets include, library, and pkg-config paths for compiling software
against this installation.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: library")
whatis("Description: JPEG codec")
whatis("URL: https://libjpeg-turbo.org")

local root = "${TOOL_PATH}"

prepend_path("PATH",            pathJoin(root, "bin"))
prepend_path("CPATH",           pathJoin(root, "include"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "$LIB"))
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "$PKG_CONF"))

-- Build helper flags
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"))
prepend_path("LDFLAGS",  "-L" .. pathJoin(root, "$LIB"))
