help([[
${TOOL} - 2D graphics library
Version: ${TOOL_VERSION}

Provides the ${TOOL} 2D graphics library required for R graphics
(png(), svg(), pdf(), and other Cairo-based devices).
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: library")
whatis("Description: Cairo 2D graphics library")
whatis("URL: https://www.cairographics.org/")

local base = "${TOOL_PATH}"

-- Binaries
prepend_path("PATH", pathJoin(base, "bin"))

-- Libraries (correct directory: lib64)
prepend_path("LD_LIBRARY_PATH", pathJoin(base, "$LIB"))
prepend_path("LIBRARY_PATH",    pathJoin(base, "$LIB"))

-- Includes
prepend_path("CPATH",              pathJoin(base, "include"))
prepend_path("CPLUS_INCLUDE_PATH", pathJoin(base, "include"))

-- pkg-config (correct directory: lib64/pkgconfig)
prepend_path("PKG_CONFIG_PATH", pathJoin(base, "$PKG_CONF"))

-- Optional Cairo-related environment variables
-- (Note: These stay as CAIRO_ because this is the specific Cairo template)
setenv("CAIRO_ROOT", base)
setenv("CAIRO_DIR",  base)
setenv("CAIRO_HOME", base)

-- Flags that R or compilation scripts may rely on
setenv("CAIRO_CFLAGS", "-I" .. pathJoin(base, "include/cairo"))
setenv("CAIRO_LIBS",   "-L" .. pathJoin(base, "$LIB") .. " -lcairo")

-- Global compiler and linker flags
prepend_path("CPPFLAGS", "-I" .. pathJoin(base, "include"), " ")
prepend_path("LDFLAGS",  "-L" .. pathJoin(base, "$LIB"),   " ")

-- Man pages
prepend_path("MANPATH", pathJoin(base, "share/man"))
