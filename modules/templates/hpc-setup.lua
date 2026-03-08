
-- Core libraries
whatis("HPC setup - core stack")

load(
  "gum",
  "zlib",
  "pkgconf",
  "libffi",
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
  "sqlite3",
  "libexpat",
  "gperf",
  "glib",
  "freetype2",
  "fontconfig",
  "magick",
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
  "fd",
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
  "modkit",
  "pod5",
  "bwa-mem2",
  "bedtools"
)
