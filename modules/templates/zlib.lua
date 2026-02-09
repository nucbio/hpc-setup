-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - A mass-appeal lossless data-compression library.

This is a foundational "Core" library. It is required by almost all other
modules in the stack, including OpenSSL, LibPNG, Python, and R.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Library/Compression")
whatis("Description: zlib is a general-purpose, lossless data-compression library.")
whatis("URL: https://zlib.net/")

local root = "${TOOL_PATH}"

-- Libraries
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib"))

-- Includes
prepend_path("CPATH",           pathJoin(root, "include"))
prepend_path("LDFLAGS", "-L" .. pathJoin(root, "lib"), " ")
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"), " ")
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/pkgconfig"))

-- Environment variables for compilers and other tools
setenv("ZLIB_ROOT", root)
setenv("ZLIB_HOME", root)
setenv("ZLIB_INCLUDE_DIR", pathJoin(root, "include"))
setenv("ZLIB_LIBRARY",     pathJoin(root, "lib"))

-- Man pages
prepend_path("MANPATH", pathJoin(root, "share/man"))

