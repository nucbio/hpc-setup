**Installation of Bioinformatic tools into a single directory** on Linux distributives (Debian/Ubuntu/RHEL/Fedora) **without root permission** (see Prerequisites). 

**Note**: The current hpc-setup is made for `x86_64` systems.

## Prerequisites
To download, unpack, and compile the software, the following packages must be installed before the hpc-setup:  

- Download: `wget`.
- Parser: `libxml2` (see unresolved dependencies)
- Unpack: `tar`, `gzip`, `xz` (xz-utils), `bzip2`
- Compile: `g++`, `gcc`, `gfortran`
- Build: `make`,`cmake`.

For Debian/Ubuntu linux distributives you can install them all as:
```bash
sudo apt update
sudo apt install wget tar gzip build-essential cmake gfortran libxml2-dev libcrypt-dev libuv1-dev
```

**Note for Minimal Systems**: The only strict system requirements are the C/C++ 
compilers (gcc, g++). All other dependencies—including cmake, make, and 
archiving utilities—can be deployed without root privileges via portable 
binaries, precompiled distributions, or by compiling from source.  

**New dependency detected**: Ubuntu 24.04 fresh installation require `libuv1-dev` 
for `fs` R package. Previously did not appear. 

### R Configuration with X11 Support

X11 is required for graphical displays and interactive plotting windows on 
local Linux desktops.  
To enable X11 support in R, the X11 development libraries should be installed 
before the hpc-setup.  
If the X11 libraries are missing (normally on HPC), R will be configured 
without X11 support.  

For Debian/Ubuntu systems, run the following command:

```bash
sudo apt update
sudo apt install libx11-dev libxt-dev libxext-dev
```

You can install all mentioned dependencies on Fedora as following:
```bash
sudo dnf upgrade --refresh
sudo dnf install -y wget tar gzip gcc gcc-c++ gcc-gfortran make cmake libxml2-devel
sudo dnf install libX11-devel libXt-devel libXext-devel
# Perl
sudo dnf install -y perl perl-core perl-CPAN
```

## Installation
Start hpc-setup from inside of the directory as:

```bash
wget -qO- https://github.com/nucbio/hpc-setup/raw/main/boot.sh | bash
```

To avoid installation interruptions on local machines, use `systemd-inhibit 
--what=sleep:idle bash` before starting the installation command.

### Resume / rebuild
Every installed package gets a stamp in `.stamps/NAME-VERSION.done`. If an 
installation fails, fix the cause and start the same command again in the same 
directory: finished packages are skipped (`[SKIP]`), the failed package is 
cleaned up and built again, and the build directory chosen on the first run 
is reused. Downloaded archives in `sources` are kept.

- Rebuild packages: `wget -qO- https://github.com/nucbio/hpc-setup/raw/main/boot.sh | FORCE_REBUILD="openssl zlib" bash` 
  (`FORCE_REBUILD=all` rebuilds everything; `lmod` and `luarocks` are also accepted). 
  `FORCE_REBUILD` is not remembered: leave it out on the next rerun.
- Or delete the stamp: `rm .stamps/openssl-*.done`.
- A new version in `pkgs.json` is installed next to the old one on the next run.
- `[STALE]` means the install script changed since the package was built; it is 
  not rebuilt unless you ask for it with `FORCE_REBUILD`.
- Python packages and R libraries have no stamp: they are checked on every run 
  and only missing packages are installed. The final test always runs.

## Installation Sequence
1. **Core packages**: bzip2, cairo, fontconfig, freetype, fribidi, gettext, 
glib, gperf, gum, harfbuzz, imagemagick, libcurl, libexpat, libff, libjpeg, 
libpng, libtiff, libvips, libwebp, ncurses, openssl, pandoc, pcre2, pkgconf, 
readline, sqlite, tcl, xz, zlib, hdf5.  
2. **Development**: R, Python, Rust, Java, Lua.  
3. **Bioinformatic tools**:  htslib, samtools, bowtie2, cutadapt, fastqc, gatk, 
pigz, dorado, duckdb, modkit, pod5.  
Legacy Nanopore tools for old R9.4.1/fast5 data: ont-guppy 6.5.7, nanopolish 0.13.2 
(not in the meta-modules; load with `module load ont-guppy` / `module load nanopolish`). 
4. **Terminal (CLI) tools**: nvim, git, bat, eza, fdfind, ripgrep, tree, zoxide.  

## Structure
- Downloaded archives are in `sources` directory.
- Installed packages are in `package/package-version` directories.
- Environmental module (`Lmod`) is installed and should be added to the .bashrc or export PATH.
- Environmental module files are in `modulefiles/package` directory with `version.lua` module files.

## Unresolved dependencies
`libxml2` library can be installed locally. However, the configuration of R 
package `XML` failed due to the problems to find linked libraries for `libxml2` 
via pkgconf or environmental variables in loaded module.  
It is known bug in XML but the only solution is to have system installed `libxml2-dev`.
