-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - A free, high-quality, and portable font engine
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: library")
whatis("Description: A free, high-quality, and portable font engine")
whatis("URL: https://freetype.org/")

local root = "${TOOL_PATH}"

-- Prepend paths
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib"))
prepend_path("CPATH",           pathJoin(root, "include"))
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/x86_64-linux-gnu/pkgconfig"))
prepend_path("MANPATH",         pathJoin(root, "share/man"))
prepend_path("ACLOCAL_PATH",    pathJoin(root, "share/aclocal"))

-- Set environment variables
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include/freetype2"), " ")
prepend_path("CFLAGS",   "-I" .. pathJoin(root, "include/freetype2"), " ")
prepend_path("CXXFLAGS", "-I" .. pathJoin(root, "include/freetype2"), " ")
prepend_path("LDFLAGS",  "-L" .. pathJoin(root, "lib"), " ")

-- Environmental varialbes
setenv("FREETYPE_CFLAGS", "-I" .. pathJoin(root, "include/freetype2"))
setenv("FREETYPE_LIBS",   "-L" .. pathJoin(root, "lib") .. " -lfreetype")

setenv("FREETYPE_ROOT",    root)
setenv("FREETYPE_HOME",    root)
setenv("FREETYPE_INCLUDE", pathJoin(root, "include"))
setenv("FREETYPE_LIB",     pathJoin(root, "lib"))

-- Conflict with other versions
conflict("${TOOL}")
