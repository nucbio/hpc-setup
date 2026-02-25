# TMP directory for compilations
TMP_DIR <- "/tmp/r-pkg-build"
dir.create(TMP_DIR, showWarnings = FALSE, recursive = TRUE)
Sys.setenv(TMPDIR = TMP_DIR)

repos = list(CRAN="http://cran.rstudio.com/")
cores <- min(6, parallel::detectCores(), na.rm = TRUE)

install.packages("XML", type = "source", 
                 dependencies = TRUE, repos = repos, Ncpus = cores)

## CRAN PACKAGES
#install.packages('XML', dependencies = TRUE, repos = repos)

install.packages(
  c(
    'devtools',       # development packange (also knitr, roxygen, markdown)
    'tidyverse',      # data manipulation
    'data.table',     # data manipulation
    'e1071',          # stat functions
    'corrplot',       # ggplot extension
    'cowplot',        # ggplot extension
    'RColorBrewer',   # ggplot extension
    'colorRamps',     # ggplot extension 
    'GGally'          # ggplot extension
   ), dependencies = TRUE, repos = repos, Ncpus = cores)

## BIOCONDUCTOR PACKAGES
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos = repos, Ncpus = cores)
# devel version
BiocManager::install(ask = FALSE)
BiocManager::valid()              # checks for out of date packages

BiocManager::install(
  c(
    'GenomicRanges',
    'BiocGenerics',
    'TxDb.Scerevisiae.UCSC.sacCer3.sgdGene',
    'BSgenome.Scerevisiae.UCSC.sacCer3',
    'rtracklayer',
    'Rsamtools'
   ), ask = FALSE, Ncpus = cores)     
BiocManager::install(ask = FALSE, Ncpus = cores)  # update packages

   
## Laboratory Packages
# Install the packages from GitLab 
devtools::install_gitlab("mglab/loci") 
devtools::install_gitlab("mglab/seqtools") 
devtools::install_gitlab("mglab/fiber")
