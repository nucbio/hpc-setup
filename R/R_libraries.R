# TMP directory for compilations
TMP_DIR <- "/tmp/r-pkg-build"
dir.create(TMP_DIR, showWarnings = FALSE, recursive = TRUE)
Sys.setenv(TMPDIR = TMP_DIR)

# R downloads all dependencies in parallel; the default 60 s timeout makes
# some of them fail silently ("download of package 'X' failed")
options(timeout = 600)
repos = list(CRAN="https://cloud.r-project.org/")
cores <- min(6, parallel::detectCores(), na.rm = TRUE)

# Safe to rerun (resume of a failed installation): only packages that are not
# installed yet are installed, nothing is updated. install.packages() and
# BiocManager::install() only warn when a package fails, so the script checks
# at the end that every package is there and fails otherwise.
not_installed <- function(pkgs) setdiff(pkgs, rownames(installed.packages()))

cran_install <- function(pkgs, ...) {
  pkgs <- not_installed(pkgs)
  if (length(pkgs) > 0)
    install.packages(pkgs, dependencies = TRUE, repos = repos, Ncpus = cores, ...)
}

CRAN_PKGS <- c(
  'devtools',       # development packange (also knitr, roxygen, markdown)
  'tidyverse',      # data manipulation
  'data.table',     # data manipulation
  'e1071',          # stat functions
  'corrplot',       # ggplot extension
  'cowplot',        # ggplot extension
  'RColorBrewer',   # ggplot extension
  'colorRamps',     # ggplot extension
  'GGally'          # ggplot extension
)

BIOC_PKGS <- c(
  'GenomicRanges',
  'BiocGenerics',
  'TxDb.Scerevisiae.UCSC.sacCer3.sgdGene',
  'BSgenome.Scerevisiae.UCSC.sacCer3',
  'rtracklayer',
  'Rsamtools'
)

cran_install("XML", type = "source")

## CRAN PACKAGES
cran_install(CRAN_PKGS)

## BIOCONDUCTOR PACKAGES
cran_install("BiocManager")
# Set up Bioconductor (no updates of installed packages)
BiocManager::install(ask = FALSE, update = FALSE)
BiocManager::valid()              # checks for out of date packages

bioc_missing <- not_installed(BIOC_PKGS)
if (length(bioc_missing) > 0)
  BiocManager::install(bioc_missing, ask = FALSE, update = FALSE, Ncpus = cores)

## Laboratory Packages
# Install the packages from GitLab (skipped if the commit is already
# installed; an error stops the script)
devtools::install_gitlab("mglab/loci", upgrade = "never")
devtools::install_gitlab("mglab/seqtools", upgrade = "never")
devtools::install_gitlab("mglab/fiber", upgrade = "never")

## Fail loudly if a package could not be installed
missing_pkgs <- not_installed(c("XML", CRAN_PKGS, "BiocManager", BIOC_PKGS))
if (length(missing_pkgs) > 0) {
  message("ERROR: R packages not installed: ", paste(missing_pkgs, collapse = ", "))
  quit(status = 1)
}
message("All R packages installed.")
