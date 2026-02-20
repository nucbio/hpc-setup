-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION}
ImageMagick image processing library and tools.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: library")
whatis("Description: ImageMagick image processing library")
whatis("URL: https://imagemagick.org")

local root = "${TOOL_PATH}"

-- Binaries (MagickCore, MagickWand tools, convert, identify, etc.)
prepend_path("PATH",            pathJoin(root, "bin"))

-- Headers
prepend_path("CPATH",           pathJoin(root, "include"))

-- Libraries
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "$LIB"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "$LIB"))

-- pkg-config (MagickCore, MagickWand)
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "$PKG_CONF"))

-- Build helper flags
prepend_path("CPPFLAGS", "-I" .. pathJoin(root, "include"), " ")
prepend_path("LDFLAGS",  "-L" .. pathJoin(root, "$LIB"), " ")

-- Optional: ensure correct Magick configuration detection
setenv("MAGICK_HOME", root)

