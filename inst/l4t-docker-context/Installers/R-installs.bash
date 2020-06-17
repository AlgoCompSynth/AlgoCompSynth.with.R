#! /bin/bash

source $WORKON_HOME/r-reticulate/bin/activate
alias make="make --jobs=`nproc`"

echo "Installing R packages"
/usr/bin/time Rscript -e "source('$HOME/Installers/R-installs.R')"
