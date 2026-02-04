Installation of Bioinformatic tools into a single directory witout root permission.

Start script from inside of the directory as:

```bash
wget -qO- https://github.com/nucbio/hpc-setup/raw/main/boot.sh | bash
```
## Prerequisites
Package `build-essential` containing `g++`, `make`, `gcc`, `libc-dev` must be installed:

`sudo apt update && sudo apt install build-essential`

## Installation Sequence
1. Core packages (dependencies)  
2. Python  
3. Installers  
4. R dependencies  
5. R  
6. Bioinformatic tools  
7. Terminal (CLI) tools  

## Structure
- Downloaded archives are in `sources` directory.
- Installed packages are in `package/package-version` directories.
- Environmental module files are in `modulefiles/package` directory with `version.lua` module files.
