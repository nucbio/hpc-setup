-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - Free Implementation of the Unicode Bidirectional Algorithm
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: library")
whatis("Description: Free Implementation of the Unicode Bidirectional Algorithm")
whatis("URL: https://github.com/fribidi/fribidi")

local root = "${TOOL_PATH}"

-- Prepend paths
prepend_path("PATH",            pathJoin(root, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "$LIB"))
prepend_path("CPATH",           pathJoin(root, "include"))
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "$PKG_CONF"))
prepend_path("MANPATH",         pathJoin(root, "share/man"))

prepend_path("CFLAGS",   "-I" .. pathJoin(root, "include"), " ")
prepend_path("CXXFLAGS", "-I" .. pathJoin(root, "include"), " ")
prepend_path("LDFLAGS",  "-L" .. pathJoin(root, "$LIB"), " ")
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"), " ")

-- Set environment variables
setenv("FRIBIDI_ROOT",    root)
setenv("FRIBIDI_HOME",    root)
setenv("FRIBIDI_INCLUDE", pathJoin(root, "include"))
setenv("FRIBIDI_LIB",     pathJoin(root, "lib"))
-- Conflict with other versions of the same tool
conflict("${TOOL}")
