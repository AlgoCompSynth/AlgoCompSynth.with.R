#! /bin/bash

source $WORKON_HOME/r-reticulate/bin/activate

echo "Installing R packages"
export MAKE="make --jobs=`nproc`"
/usr/bin/time $HOME/Installers/R-installs.R
