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

## Installation
Start hpc-setup from inside of the directory as:

```bash
wget -qO- https://github.com/nucbio/hpc-setup/raw/main/boot.sh | bash
```

## Installation Sequence
1. Core packages (dependencies)  
2. Python, Rust, Java etc.  
4. Meson based dependencies  
5. R  
6. Bioinformatic tools  
7. Terminal (CLI) tools  

## Structure
- Downloaded archives are in `sources` directory.
- Installed packages are in `package/package-version` directories.
- Environmental module (`Lmod`) is installed and should be added to the .bashrc or export PATH.
- Environmental module files are in `modulefiles/package` directory with `version.lua` module files.
