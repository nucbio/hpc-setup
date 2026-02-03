-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - Free Implementation of the Unicode Bidirectional Algorithm
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: library")
whatis("Description: Free Implementation of the Unicode Bidirectional Algorithm")
whatis("URL: https://github.com/fribidi/fribidi")

local base = "${TOOL_PATH}"

-- Prepend paths
prepend_path("PATH",            pathJoin(base, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(base, "lib"))
prepend_path("LIBRARY_PATH",    pathJoin(base, "lib"))
prepend_path("CPATH",           pathJoin(base, "include"))
prepend_path("PKG_CONFIG_PATH", pathJoin(base, "lib/pkgconfig"))
prepend_path("MANPATH",         pathJoin(base, "share/man"))

-- Set environment variables for R package compilation
setenv("FRIBIDI_ROOT",    base)
setenv("FRIBIDI_HOME",    base)
setenv("FRIBIDI_INCLUDE", pathJoin(base, "include"))
setenv("FRIBIDI_LIB",     pathJoin(base, "lib"))

-- Additional variables that R's configure scripts might check
pushenv("CFLAGS",   "-I" .. pathJoin(base, "include"))
pushenv("CXXFLAGS", "-I" .. pathJoin(base, "include"))
pushenv("LDFLAGS",  "-L" .. pathJoin(base, "lib"))

-- For R packages that might look for fribidi headers
pushenv("CPPFLAGS", "-I" .. pathJoin(base, "include"))

-- Conflict with other versions of the same tool
conflict("${TOOL}")
