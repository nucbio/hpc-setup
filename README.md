**Installation of Bioinformatic tools into a single directory** on Linux distributives (Debian/Ubuntu/RHEL/Fedora) **without root permission** (see Prerequisites). 

**Note**: The current hpc-setup is made for `x86_64` systems.

## Prerequisites
To download, unpack, and compile the software, the following packages must be installed before the hpc-setup:  

- Download: `wget`.
- Unpack: `tar`, `gzip`, `xz` (xz-utils), `bzip2`
- Compile: `g++`, `gcc`, `gfortran`
- Build: `make`,`cmake`.

For Debian/Ubuntu linux distributives you can install them all as:
```bash
sudo apt update
sudo apt install wget tar gzip xz-utils bzip2 build-essential cmake gfortran
```

**Note for Minimal Systems**: The only strict system requirements are the C/C++ compilers (gcc, g++). All other dependencies—including cmake, make, and archiving utilities—can be deployed without root privileges via portable binaries, precompiled distributions, or by compiling from source.  

### R Configuration with X11 Support

X11 is required for graphical displays and interactive plotting windows on local Linux desktops.  
To enable X11 support in R, the X11 development libraries should be installed before the hpc-setup.  
If the X11 libraries are missing (normally on HPC), R will be configured without X11 support.  

For Debian/Ubuntu systems, run the following command:

```bash
sudo apt update
sudo apt install libx11-dev libxt-dev libxext-dev
```

You can install all mentioned dependencies on Fedora as following:
```bash
sudo dnf upgrade --refresh
sudo dnf install -y wget tar gzip xz bzip2 gcc gcc-c++ gcc-gfortran make cmake
sudo dnf install libX11-devel libXt-devel libXext-devel
```

## Installation
Start hpc-setup from inside of the directory as:

```bash
wget -qO- https://github.com/nucbio/hpc-setup/raw/main/boot.sh | bash
```

## Installation Sequence
1. **Core packages**: bzip2, cairo, freetype, fribidi, gettext, glib, gum, 
harfbuzz, libcurl, libexpat, libff, libjpeg, libpng, libvips, libwebp, ncurses, 
openssl, pandoc, pcre2, pkgconf, readline, sqlite, tcl, xz, zlib.  
2. **Development**: R, Python, Rust, Java, Lua.  
3. **Bioinformatic tools**:  htslib, samtools, bowtie2, cutadapt, fastqc, gatk, 
pigz. dorado hdf5 duckdb modkit pod5. 
4. **Terminal (CLI) tools**: nvim, bat, eza, fdfind, ripgrep, tree, zoxide.  

## Structure
- Downloaded archives are in `sources` directory.
- Installed packages are in `package/package-version` directories.
- Environmental module (`Lmod`) is installed and should be added to the .bashrc or export PATH.
- Environmental module files are in `modulefiles/package` directory with `version.lua` module files.
