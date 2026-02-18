-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - Fast XML parser library written in C.

This module provides the headers, libraries, and tools (xmlwf) 
required for XML parsing. It is a key dependency for fontconfig,
DBus, and various bioinformatics software.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Library/XML")
whatis("Description: Expat is an XML parser library written in C. It is a stream-oriented parser.")
whatis("URL: https://libexpat.github.io/")

local root = "${TOOL_PATH}"

-- Binaries (xmlwf - for checking well-formedness of XML)
prepend_path("PATH",            pathJoin(root, "bin"))

-- Libraries
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "$LIB"))

-- Includes
prepend_path("CPATH",           pathJoin(root, "include"))

-- pkg-config (Crucial for fontconfig and other Autotools builds)
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "$PKG_CONF"))

-- Variables
setenv("EXPAT_ROOT",        root)
setenv("EXPAT_INCLUDE_DIR", pathJoin(root, "include"))
setenv("EXPAT_LIBRARY",     pathJoin(root, "$LIB"))
setenv("EXPAT_LIBS",        "-L" .. pathJoin(root, "$LIB") .. " -lexpat")

-- Man pages
prepend_path("MANPATH", pathJoin(root, "share/man"))

conflict("${TOOL}")
