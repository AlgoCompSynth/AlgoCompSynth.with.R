#! /bin/bash

echo "Installing R Linux dependencies"
apt-get install -qqy --no-install-recommends \
  git \
  git-lfs \
  libfftw3-dev \
  libsodium-dev \
  libssh2-1-dev \
  libssl-dev \
  libxml2-dev \
  nano \
  pandoc \
  pandoc-citeproc \
  pandoc-citeproc-preamble
apt-get autoremove --purge -y
apt-get clean
