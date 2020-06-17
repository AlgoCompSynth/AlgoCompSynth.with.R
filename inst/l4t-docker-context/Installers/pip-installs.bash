#! /bin/bash

source $WORKON_HOME/r-reticulate/bin/activate
alias make="make --jobs=`nproc`"

echo "Installing 'numpy', 'Cython' and 'SymPy'"
/usr/bin/time pip install numpy Cython SymPy

pip list
