
-- Core libraries
whatis("HPC setup - core stack")

load(
  "zlib",
  "pkgconf",
  "libff",
  "bzip2",
  "pcre2",
  "xz",
  "libpng",
  "libtiff",
  "libjpeg",
  "libwebp",
  "pandoc",
  "openssl",
  "libcurl",
  "ncurses",
  "readline",
  "gettext",
  "sqlite",
  "libexpat",
  "gperf",
  "glib",
  "freetype",
  "fontconfig",
  "imagemagick",
  "fribidi",
  "harfbuzz",
  "cairo",
  "libvips"
)

-- Dev-tools
load(
    "java",
    "python",
    "R",
    "rust",
    "lua"
)

-- Terminal utils
load(
  "bat",
  "eza",
  "fdfind",
  "git",
  "nvim",
  "ripgrep",
  "tree",
  "zoxide"
)

-- Bioinformatic tools
load(
  "htslib",
  "bowtie2",
  "cutadapt",
  "deeptools",
  "fastqc",
  "gatk",
  "macs3",
  "pigz",
  "samtools",
  "dorado",
  "duckdb",
  "hdf5",
  "modkit",
  "pod5"
)
