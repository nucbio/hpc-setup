-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - A free, high-quality, and portable font engine
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: library")
whatis("Description: A free, high-quality, and portable font engine")
whatis("URL: https://freetype.org/")

local base = "${TOOL_PATH}"

-- Prepend paths
prepend_path("LD_LIBRARY_PATH", pathJoin(base, "lib64"))
prepend_path("LIBRARY_PATH",    pathJoin(base, "lib64"))
prepend_path("CPATH",           pathJoin(base, "include"))
prepend_path("PKG_CONFIG_PATH", pathJoin(base, "lib64/pkgconfig"))
prepend_path("MANPATH",         pathJoin(base, "share/man"))
prepend_path("ACLOCAL_PATH",    pathJoin(base, "share/aclocal"))

-- Set environment variables for R package compilation
setenv("FREETYPE_ROOT",    base)
setenv("FREETYPE_HOME",    base)
setenv("FREETYPE_INCLUDE", pathJoin(base, "include"))
setenv("FREETYPE_LIB",     pathJoin(base, "lib64"))

-- Additional variables that R's configure scripts might check
-- Using pushenv as per your original file
pushenv("CFLAGS",   "-I" .. pathJoin(base, "include/freetype2"))
pushenv("CXXFLAGS", "-I" .. pathJoin(base, "include/freetype2"))
pushenv("LDFLAGS",  "-L" .. pathJoin(base, "lib64"))

-- For R packages that might look for freetype-config style variables
pushenv("CPPFLAGS",      "-I" .. pathJoin(base, "include/freetype2"))
setenv("FREETYPE_CFLAGS", "-I" .. pathJoin(base, "include/freetype2"))
setenv("FREETYPE_LIBS",   "-L" .. pathJoin(base, "lib64") .. " -lfreetype")

-- Conflict with other versions of the same tool
conflict("${TOOL}")
