#! /bin/bash

echo "Installing RStudio Server build dependencies"
apt-get update
apt-get install -qqy --no-install-recommends \
  ant \
  build-essential \
  cmake \
  git \
  libpam0g-dev \
  libssl-dev \
  openjdk-8-jre-headless \
  openjdk-8-jdk-headless \
  pandoc \
  pandoc-citeproc \
  r-base-dev \
  time \
  uuid-dev

rm -fr rstudio
git clone https://github.com/rstudio/rstudio.git && \
  cd rstudio && \
  git checkout $RSTUDIO_TAG

# Non-L4t Dependencies
export PANDOC_VERSION=`pandoc --version|head -n 1|sed 's/^pandoc //'`
echo "PANDOC_VERSION=$PANDOC_VERSION"
pushd dependencies/common && \
  echo "Installing RStudio boost from source - may take a while"
  /usr/bin/time ./install-boost > $SOURCE_DIR/install-boost.log 2>&1 && \
  gzip -9 $SOURCE_DIR/install-boost.log && \
  ./install-dictionaries > /dev/null 2>&1 && \
  ./install-mathjax > /dev/null 2>&1 && \
  mkdir -p pandoc/$PANDOC_VERSION/ && \
  cp /usr/bin/pandoc* pandoc/$PANDOC_VERSION/
popd

echo "CMake"
mkdir --parents $SOURCE_DIR/rstudio/build/ && cd $SOURCE_DIR/rstudio/build/
cmake .. \
  -DRSTUDIO_TARGET=Server -DCMAKE_BUILD_TYPE=Release -DCPACK_GENERATOR=TGZ -DCPACK_SOURCE_GENERATOR=TGZ

echo "Packaging"

# use half of `nproc` for make job count
export CODE="n=`nproc`; n/2"
echo "'bc' code is $CODE"
export JOBS=`echo $CODE | bc`
echo "'make' will use $JOBS jobs"
/usr/bin/time make --jobs=$JOBS package

echo "RStudio Server package tarball is in $SOURCE_DIR/rstudio/build/$PACKAGE_FILE"
echo "Install with 'tar --directory=/ --strip-components=1 -xvf $PACKAGE_FILE'"

echo "Checking tarball"
/usr/bin/time make --jobs=$JOBS install
tar xf $SOURCE_DIR/rstudio/build/$PACKAGE_FILE
diff --recursive \
  ./rstudio-server-$RSTUDIO_VERSION-arm64/usr/local/lib/rstudio-server/ \
  /usr/local/lib/rstudio-server/ \
  > $SOURCE_DIR/install-tarball-diff.log 
