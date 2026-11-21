#!/bin/bash

# Legacy Nanopore tools, kept to re-analyse old data (R9.4.1, fast5).
# Both are deprecated by ONT and not part of the meta-modules:
# load them explicitly with `module load ont-guppy` / `module load nanopolish`.
#   ont-guppy  - basecaller replaced by dorado (dorado >= 1.0 has no R9.4.1 models).
#   nanopolish - call-methylation / eventalign; R9.4.1 only (no R10.4.1 model).

### ont-guppy ###

echo "Install ont-guppy"

# GPU build (bundles its own CUDA libraries); also runs on CPU without --device.
GUPPY_VERSION=$(pkg_version "ont-guppy")
export GUPPY_VERSION

pkg_install \
  -n "ont-guppy" \
  -t "unpack"

### nanopolish ###

echo "Install nanopolish"

module purge
module load zlib

PKG_NAME="nanopolish"
PKG_VERSION=$(pkg_version "$PKG_NAME")
export NANOPOLISH_VERSION="$PKG_VERSION"

# GitHub has no release tarball with submodules: download the tag and the
# submodule commits pinned by v0.13.2 separately (no git needed).
PKG_URL=$(pkg_url "$PKG_NAME")
PKG_ARCHIVE="$SOURCES_DIR/$PKG_NAME-$PKG_VERSION.tar.gz"

SUBMODULES=(
  "htslib|samtools/htslib|3dc96c5699a26c5a46e3ccca4092b3801e1874f4"
  "minimap2|lh3/minimap2|d2de282d21e9b621dc5f6cef293cb60b93cc553d"
  "fast5|mateidavid/fast5|18d6e346cadb9990ff8287e54447f90e76dd79bc"
)

# Bundled dependencies the Makefile would otherwise download itself
HDF5_VERSION="1.8.14"
HDF5_URL="https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-${HDF5_VERSION}/src/hdf5-${HDF5_VERSION}.tar.gz"
EIGEN_VERSION="3.3.7"
EIGEN_URL="https://gitlab.com/libeigen/eigen/-/archive/${EIGEN_VERSION}/eigen-${EIGEN_VERSION}.tar.bz2"

# VBZ HDF5 plugin to read VBZ-compressed fast5 (zstd linked statically)
VBZ_VERSION="1.0.1"
VBZ_URL="https://files.pythonhosted.org/packages/d2/dd/eab7a9cac698afd8d4d469d703303390a88570ace01da358088459a6a48d/vbz_h5py_plugin-${VBZ_VERSION}-py3-none-any.whl"
VBZ_ARCHIVE="$SOURCES_DIR/vbz_h5py_plugin-${VBZ_VERSION}-py3-none-any.whl"

# Already installed by a previous run? (see functions/stamp.sh)
# (nanopolish is the last part of this file)
if skip_if_installed "$PKG_NAME" "$PKG_VERSION"; then
  return 0
fi

# Set PKG_SRC_DIR, PKG_PREFIX
set_pkg_dirs $PKG_NAME $PKG_VERSION

wget -nv "$PKG_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

for SUB in "${SUBMODULES[@]}"; do
  IFS='|' read -r SUB_DIR SUB_REPO SUB_COMMIT <<< "$SUB"
  SUB_ARCHIVE="$SOURCES_DIR/$PKG_NAME-$PKG_VERSION-$SUB_DIR-${SUB_COMMIT:0:7}.tar.gz"
  wget -nv "https://github.com/$SUB_REPO/archive/$SUB_COMMIT.tar.gz" -O "$SUB_ARCHIVE"
  mkdir -p "$PKG_SRC_DIR/$SUB_DIR"
  tar -xzf "$SUB_ARCHIVE" -C "$PKG_SRC_DIR/$SUB_DIR" --strip-components=1
done

# HDF5: the Makefile builds it from hdf5-<version>.tar.gz in the source dir
wget -nv "$HDF5_URL" -O "$SOURCES_DIR/hdf5-$HDF5_VERSION.tar.gz"
cp "$SOURCES_DIR/hdf5-$HDF5_VERSION.tar.gz" "$PKG_SRC_DIR/"

# Eigen: header-only; an existing eigen/INSTALL makes the Makefile skip its download
wget -nv "$EIGEN_URL" -O "$SOURCES_DIR/eigen-$EIGEN_VERSION.tar.bz2"
mkdir -p "$PKG_SRC_DIR/eigen"
tar -xjf "$SOURCES_DIR/eigen-$EIGEN_VERSION.tar.bz2" -C "$PKG_SRC_DIR/eigen" --strip-components=1

# Build in the source dir (bundled hdf5, eigen, htslib, minimap2).
# HDF5 first: the Makefile does not make objects wait for hdf5.h,
# so a plain `make -j` races and fails with "hdf5.h: No such file".
cd "$PKG_SRC_DIR"
make -j $(nproc) lib/libhdf5.a
make -j $(nproc)

# Install binary and helper scripts
mkdir -p "$PKG_PREFIX/bin"
cp nanopolish "$PKG_PREFIX/bin/"
cp -r scripts "$PKG_PREFIX/"

# VBZ plugin (HDF5_PLUGIN_PATH is set by the module)
wget -nv "$VBZ_URL" -O "$VBZ_ARCHIVE"
mkdir -p "$PKG_PREFIX/lib/hdf5_plugin"
unzip -p "$VBZ_ARCHIVE" vbz_h5py_plugin/lib/libvbz_hdf_plugin_x86_64.so \
  > "$PKG_PREFIX/lib/hdf5_plugin/libvbz_hdf_plugin.so"

cd "$REPO_DIR"
rm -rf "$PKG_SRC_DIR"

# Create Module file
module_templater "$PKG_NAME"
