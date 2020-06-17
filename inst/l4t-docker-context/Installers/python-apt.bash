#! /bin/bash

echo "Installing Python Linux dependencies"
apt-get install -qqy --no-install-recommends \
  hdf5-tools \
  libffi-dev \
  libhdf5-dev \
  libhdf5-serial-dev \
  libjpeg8-dev \
  libopenblas-base \
  libopenmpi-dev \
  python-dev \
  python3-dev \
  python-pip \
  python3-pip \
  python-virtualenv \
  python3-virtualenv \
  virtualenv \
  virtualenvwrapper \
  zip \
  zlib1g-dev
apt-get autoremove --purge -y
apt-get clean
