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

local root = "$TOOL_PATH"
local bin = pathJoin(root, "bin")
local lib = pathJoin(root, "$LIB")
local include = pathJoin(root, "include")
local pkg_conf = pathJoin(root, "$PKG_CONF")
local man = pathJoin(root, "share/man")

-- Variabless
prepend_path("PATH",               bin)
prepend_path("LD_LIBRARY_PATH",    lib)
prepend_path("LIBRARY_PATH",       lib)
prepend_path("CPATH",              include)
prepend_path("CPLUS_INCLUDE_PATH", include)
prepend_path("PKG_CONFIG_PATH",    pkg_conf)

-- Optional Cairo-related environment variables
setenv("CAIRO_ROOT", root)
setenv("CAIRO_DIR",  root)
setenv("CAIRO_HOME", root)

setenv("CAIRO_CFLAGS", "-I" .. pathJoin(root, "include/cairo"))
setenv("CAIRO_LIBS",   "-L" .. lib .. " -lcairo")

prepend_path("CPPFLAGS", "-I" .. include, " ")
prepend_path("LDFLAGS",  "-L" .. lib,   " ")

-- Man pages
prepend_path("MANPATH", man)

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
