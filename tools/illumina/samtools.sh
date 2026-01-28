mkdir -p samtools/samtools-1.20
cd samtools/samtools-1.20
# From Desktop copy arhive
mkdir build
tar -xjf samtools-1.20.tar.bz2
cd samtools-1.20/
./configure --disable-bz2 --prefix=/projects/p_bp/tools/samtools/samtools-1.20/build
# --disable-bz2 is because libbzip2 package dependency is missing
make && make install
