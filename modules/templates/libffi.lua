-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - A portable foreign function interface library.
libffi provides a portable, high level programming interface to various calling
conventions. This allows a programmer to call any function specified by a call
interface description at run time. It is used by many language interpreters and
runtime systems including Python, Ruby, and Java JVMs.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Library/Development")
whatis("Description: libffi is a portable foreign function interface library.")
whatis("URL: https://sourceware.org/libffi/")

local root = "${TOOL_PATH}"
local lib = pathJoin(root, "$LIB")
local include = pathJoin(root, "include")
local pkgconf = pathJoin(root, "$PKG_CONF")
local man = pathJoin(root, "share/man")

-- Libraries
prepend_path("LD_LIBRARY_PATH", lib)
prepend_path("LIBRARY_PATH",    lib)

-- Includes
prepend_path("CPATH",              include)
prepend_path("C_INCLUDE_PATH",     include)
prepend_path("CPLUS_INCLUDE_PATH", include)

-- Compiler/Linker flags
prepend_path("LDFLAGS", "-L" ..  lib, " ")
prepend_path("CPPFLAGS", "-I" .. include, " ")

-- PKG_CONFIG_PATH for .pc files
prepend_path("PKG_CONFIG_PATH", pkgconf)

-- Environment variables for build systems
setenv("LIBFFI_ROOT", root)
setenv("LIBFFI_HOME", root)
setenv("LIBFFI_INCLUDE_DIR", include)
setenv("LIBFFI_LIBRARY_DIR", lib)

-- Man pages
prepend_path("MANPATH", man)

-- Info pages
prepend_path("INFOPATH", pathJoin(root, "share/info"))

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end
