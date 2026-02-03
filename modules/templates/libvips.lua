-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION}

This module loads the ${TOOL} image processing library and all required
runtime paths. Built with dependencies installed under
${TOOL_PATH}.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Image Processing")
whatis("Description: Fast image processing library")
whatis("URL: https://libvips.github.io/libvips/")

-- Installation prefix from Bash
local root = "${TOOL_PATH}"

-- Paths
local bin        = pathJoin(root, "bin")
local lib        = pathJoin(root, "lib64")
local include    = pathJoin(root, "include")
local pkgconfig  = pathJoin(lib, "pkgconfig")
local man        = pathJoin(root, "share/man")

-- Environment setup
prepend_path("PATH",            bin)
prepend_path("LD_LIBRARY_PATH", lib)
prepend_path("LIBRARY_PATH",    lib)
prepend_path("PKG_CONFIG_PATH", pkgconfig)
prepend_path("C_INCLUDE_PATH",  include)
prepend_path("MANPATH",         man)

-- Avoid conflicts with other versions
conflict("${TOOL}")
