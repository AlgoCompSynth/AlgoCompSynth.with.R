#! /bin/bash

source $WORKON_HOME/r-reticulate/bin/activate
alias make="make --jobs=`nproc`"

echo "Installing 'numpy' and 'SymPy'"
/usr/bin/time pip install --upgrade numpy SymPy

pip list
