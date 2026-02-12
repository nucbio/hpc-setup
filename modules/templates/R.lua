-- ${TOOL} ${TOOL_VERSION} Module File

help([[
${TOOL} ${TOOL_VERSION} - Statistical Computing Environment
Loads full dependency stack for R package compilation.
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")

----------------------------------------------------------------------
-- Load required dependency modules using dynamic versions
----------------------------------------------------------------------
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
load("fontconfig/${FONTCONFIG_VERSION}")
load("libxml2/${LIBXML2_VERSION}")
load("libjpeg/${LIBJPEG_VERSION}")
load("libwebp/${LIBWEBP_VERSION}")
load("libvips/${LIBVIPS_VERSION}")
load("java/${JAVA_VERSION}")

----------------------------------------------------------------------
-- R installation paths
----------------------------------------------------------------------
local rroot = "${TOOL_PATH}"
local rversion = "${TOOL_VERSION}"

prepend_path("PATH",            pathJoin(rroot, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(rroot, "lib"))
prepend_path("PKG_CONFIG_PATH", pathJoin(rroot, "lib/pkgconfig"))
prepend_path("CPATH",           pathJoin(rroot, "include"))

----------------------------------------------------------------------
-- User library tree
----------------------------------------------------------------------
local home = os.getenv("HOME") or ""
if home ~= "" then
    local r_libs_user = pathJoin(home, "R/library", rversion)
    prepend_path("R_LIBS_USER", r_libs_user)
end

conflict("${TOOL}")

if mode() == "load" then
    LmodMessage("Loading ${TOOL} ${TOOL_VERSION} with dynamic dependencies.")
end
