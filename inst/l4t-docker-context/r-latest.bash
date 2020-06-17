#! /bin/bash

echo "Installing tools for building from source"
apt-get install -qqy --no-install-recommends \
  build-essential \
  curl \
  default-jdk-headless \
  default-jre-headless \
  gfortran \
  libbz2-dev \
  libcairo2-dev \
  libcurl4-openssl-dev \
  libicu-dev \
  libjpeg-dev \
  libjpeg-turbo8-dev \
  liblzma-dev \
  libopenblas-dev \
  libopenmpi-dev \
  libpcre2-dev \
  libpng-dev \
  libreadline-dev \
  libtiff-dev \
  texinfo \
  tk-dev \
  zlib1g-dev
apt-get autoremove --purge -y
apt-get clean

echo "Creating / entering source directory"
mkdir -p $SOURCE_DIR && cd $SOURCE_DIR

echo "Removing old R source directories"
rm -fr R-*

echo "Downloading source"
curl -Ls https://cloud.r-project.org/src/base/R-latest.tar.gz | gzip -dc | tar xf -
export R_LATEST=`ls -1 | grep -e "^R-"`
echo "Using $R_LATEST"

echo "Configuring"
mkdir --parents build_dir
cd build_dir
../$R_LATEST/configure --enable-R-shlib

echo "Compiling"
make --jobs=`nproc`

echo "Checking"
make check

echo "Installing"
make install
cp ../R.conf /etc/ld.so.conf.d/
/sbin/ldconfig
cd ..

echo "Removing build directory"
rm -fr build_dir
