-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - OpenType text shaping engine
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: library")
whatis("Description: OpenType text shaping engine")
whatis("URL: https://harfbuzz.github.io/")

local root = "${TOOL_PATH}"
local bin = pathJoin(root, "bin")
local lib = pathJoin(root, "$LIB")
local include = pathJoin(root, "include")
local include2 = pathJoin(root, "include/harfbuzz")
local pkgconf = pathJoin(root, "$PKG_CONF")

-- Prepend paths
prepend_path("PATH",            bin)
prepend_path("LD_LIBRARY_PATH", lib)
prepend_path("LIBRARY_PATH",    lib)
prepend_path("CPATH",           include)
prepend_path("PKG_CONFIG_PATH", pkgconf)

prepend_path("LDFLAGS",  "-L" .. lib, " ")
prepend_path("CFLAGS",   "-I" .. include2, " ")
prepend_path("CXXFLAGS", "-I" .. include2, " ")
prepend_path("CPPFLAGS", "-I" .. include2, " ")

-- Variables
setenv("HARFBUZZ_ROOT",    root)
setenv("HARFBUZZ_HOME",    root)
setenv("HARFBUZZ_INCLUDE", include)
setenv("HARFBUZZ_LIB",     pkgconf)

-- Conflicts
conflict("${TOOL}")

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
