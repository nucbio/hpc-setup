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

local bin = pathJoin(root, "bin")
local lib = pathJoin(root, "$LIB")
local include = pathJoin(root, "include")
local include2 = pathJoin(root, "include/fribidi")
local pkg_conf = pathJoin(root, "$PKG_CONF")
local man = pathJoin(root, "share/man")

-- Prepend paths
prepend_path("PATH",            bin)
prepend_path("LD_LIBRARY_PATH", lib)
prepend_path("LIBRARY_PATH",    lib)
prepend_path("CPATH",           include)
prepend_path("PKG_CONFIG_PATH", pkg_conf)
prepend_path("MANPATH",         man)

prepend_path("CFLAGS",   "-I" .. include2, " ")
prepend_path("CXXFLAGS", "-I" .. include2, " ")
prepend_path("LDFLAGS",  "-L" .. lib, " ")
prepend_path("CPPFLAGS", "-I" .. include2, " ")

-- Set environment variables
setenv("FRIBIDI_ROOT",    root)
setenv("FRIBIDI_HOME",    root)
setenv("FRIBIDI_INCLUDE", include)
setenv("FRIBIDI_LIB",     lib)
-- Conflict with other versions of the same tool
conflict("${TOOL}")

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
