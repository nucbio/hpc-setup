-- ${TOOL} ${TOOL_VERSION} Module File

help([[
${TOOL} ${TOOL_VERSION} - Statistical Computing Environment
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")

-- Dependencies
load("zlib/${ZLIB_VERSION}")
load("libcurl/${LIBCURL_VERSION}")
load("pcre2/${PCRE2_VERSION}")
load("bzip2/${BZIP2_VERSION}")
load("libpng/${LIBPNG_VERSION}")
load("libtiff/${LIBTIFF_VERSION}")
load("pandoc/${PANDOC_VERSION}")
load("cairo/${CAIRO_VERSION}")
load("fribidi/${FRIBIDI_VERSION}")
load("harfbuzz/${HARFBUZZ_VERSION}")
load("freetype/${FREETYPE_VERSION}")
load("imagemagick/$MAGICK_VERSION")
load("fontconfig/${FONTCONFIG_VERSION}")
load("libxml2/${LIBXML2_VERSION}")
load("libjpeg/${LIBJPEG_VERSION}")
load("libwebp/${LIBWEBP_VERSION}")
load("libvips/${LIBVIPS_VERSION}")
load("java/${JAVA_VERSION}")

-- Version conflicts
conflict("$TOOL")

-- Message
if mode() == "load" then
    LmodMessage("Loading $TOOL $TOOL_VERSION.")
end

local root = "$TOOL_PATH"

-- Paths
local bin        = pathJoin(root, "bin")
local lib        = pathJoin(root, "$LIB")
local pkgconfig  = pathJoin(root, "$PKG_CONF")
local include    = pathJoin(root, "include")

-- Variables
prepend_path("PATH",            bin)
prepend_path("LD_LIBRARY_PATH", lib)
prepend_path("PKG_CONFIG_PATH", pkgconfig)
prepend_path("CPATH",           include)

