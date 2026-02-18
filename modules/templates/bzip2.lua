-- ${TOOL} version ${TOOL_VERSION}
whatis("${TOOL} version ${TOOL_VERSION}")

local root = "${TOOL_PATH}"
local bin = pathJoin(root, "bin")
local lib = pathJoin(root, "$LIB")
local include = pathJoin(root, "include")
local man = pathJoin(root, "man")

-- Binaries
prepend_path("PATH", bin)

-- Variables
prepend_path("CPPFLAGS", "-I" .. include, " ")
prepend_path("LDFLAGS",  "-L" .. lib, " ")

prepend_path("LD_LIBRARY_PATH", lib)
prepend_path("LIBRARY_PATH",    lib)
prepend_path("CPATH",           include)
prepend_path("MANPATH",         man)
