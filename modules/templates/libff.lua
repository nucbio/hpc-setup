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

-- Libraries
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib64"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib64"))

-- Includes
prepend_path("CPATH",           pathJoin(root, "include"))
prepend_path("C_INCLUDE_PATH",  pathJoin(root, "include"))
prepend_path("CPLUS_INCLUDE_PATH", pathJoin(root, "include"))

-- Compiler/Linker flags
prepend_path("LDFLAGS", "-L" .. pathJoin(root, "lib"), " ")
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"), " ")

-- PKG_CONFIG_PATH for .pc files
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/pkgconfig"))
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib64/pkgconfig"))

-- Environment variables for build systems
setenv("LIBFFI_ROOT", root)
setenv("LIBFFI_HOME", root)
setenv("LIBFFI_INCLUDE_DIR", pathJoin(root, "include"))
setenv("LIBFFI_LIBRARY_DIR", pathJoin(root, "lib"))

-- Man pages
prepend_path("MANPATH", pathJoin(root, "share/man"))

-- Info pages
prepend_path("INFOPATH", pathJoin(root, "share/info"))
