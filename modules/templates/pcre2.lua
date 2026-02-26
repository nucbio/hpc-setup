-- ${TOOL} version ${TOOL_VERSION}
whatis("${TOOL} version ${TOOL_VERSION}")

local root = "${TOOL_PATH}"

local bin = pathJoin(root, "bin")
local lib = pathJoin(root, "$LIB")
local include = pathJoin(root, "include")
local pkgconf = pathJoin(root, "$PKG_CONF")

prepend_path("PATH", bin)
prepend_path("CPATH", include)
prepend_path("CPPFLAGS", "-I" .. include, " ")

-- Library paths
prepend_path("LD_LIBRARY_PATH", lib)
prepend_path("LIBRARY_PATH",    lib)
prepend_path("LDFLAGS", "-L" .. lib, " ")

-- pkg-config
prepend_path("PKG_CONFIG_PATH", pkgconf)

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
