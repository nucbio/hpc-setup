help([[
${TOOL} - 2D graphics library
Version: ${TOOL_VERSION}

Provides the ${TOOL} 2D graphics library required for R graphics
(png(), svg(), pdf(), and other Cairo-rootd devices).
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: library")
whatis("Description: Cairo 2D graphics library")
whatis("URL: https://www.cairographics.org/")

local root = "${TOOL_PATH}"

-- Binaries
prepend_path("PATH", pathJoin(root, "bin"))

-- Libraries (correct directory: lib64)
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "$LIB"))

-- Includes
prepend_path("CPATH",              pathJoin(root, "include"))
prepend_path("CPLUS_INCLUDE_PATH", pathJoin(root, "include"))

prepend_path("PKG_CONFIG_PATH", pathJoin(root, "$PKG_CONF"))

-- Optional Cairo-related environment variables
setenv("CAIRO_ROOT", root)
setenv("CAIRO_DIR",  root)
setenv("CAIRO_HOME", root)

setenv("CAIRO_CFLAGS", "-I" .. pathJoin(root, "include/cairo"))
setenv("CAIRO_LIBS",   "-L" .. pathJoin(root, "$LIB") .. " -lcairo")

-- Global compiler and linker flags
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"), " ")
prepend_path("LDFLAGS",  "-L" .. pathJoin(root, "$LIB"),   " ")

-- Man pages
prepend_path("MANPATH", pathJoin(root, "share/man"))
