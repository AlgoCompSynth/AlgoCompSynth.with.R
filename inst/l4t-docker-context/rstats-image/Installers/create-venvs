#! /bin/bash

echo "Creating 'WORKON_HOME'"
mkdir --parents $WORKON_HOME

echo "Creating 'PROJECT_HOME'"
mkdir --parents $PROJECT_HOME

echo "Creating virtualenv 'r-reticulate'"
virtualenv --system-site-packages --python=/usr/bin/python3 $WORKON_HOME/r-reticulate

echo "Creating user library"
Rscript -e "source('~/.Rprofile')"
