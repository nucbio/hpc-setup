-- ${TOOL} version ${TOOL_VERSION}
help([[
${TOOL} ${TOOL_VERSION} - C library for high-throughput sequencing data.

This module provides the headers and libraries for ${TOOL}. 
It is a required dependency for samtools, bcftools, bwa, and many 
R/Python bioinformatics packages.

Built with support for:
- zlib (compression)
- bzip2 (compression)
- lzma (compression)
- libcurl (remote file access via HTTPS/S3)
]])

whatis("Name: ${TOOL}")
whatis("Version: ${TOOL_VERSION}")
whatis("Category: Bioinformatics/Library")
whatis("Description: C library for handling high-throughput sequencing data formats.")
whatis("URL: http://www.htslib.org/")

----------------------------------------------------------------------
-- Dependencies (Core & Networking)
----------------------------------------------------------------------
load("zlib/${ZLIB_VERSION}")
load("bzip2/${BZIP2_VERSION}")
load("xz/${XZ_VERSION}")
load("libcurl/${LIBCURL_VERSION}")

local root = "${TOOL_PATH}"

-- Binaries (bgzip, tabix, htsfile)
prepend_path("PATH",            pathJoin(root, "bin"))

-- Libraries
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))
prepend_path("LIBRARY_PATH",    pathJoin(root, "lib"))

-- Includes
prepend_path("CPATH",           pathJoin(root, "include"))

-- pkg-config (Essential for samtools/bcftools builds)
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/pkgconfig"))

----------------------------------------------------------------------
-- Variables for downstream bioinformatics tools
----------------------------------------------------------------------
setenv("HTSLIB_DIR",  root)
setenv("HTSLIB_HOME", root)

-- Useful for R packages like 'Rsamtools' or 'numbat'
setenv("HTSLIB_INCLUDE", pathJoin(root, "include"))
setenv("HTSLIB_LIB",     pathJoin(root, "lib"))

conflict("${TOOL}")
