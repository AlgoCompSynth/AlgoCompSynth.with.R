#! /usr/bin/env bash

if [ ${#RSTATS_PASSWORD} -ge 12 ]
then
  echo "Resetting 'rstats' password"
  echo "rstats:${RSTATS_PASSWORD}" | chpasswd
else
  echo "New 'rstats' password must be at least 12 bytes!"
  echo "Exiting!"
  exit -255
fi
/usr/local/lib/rstudio-server/bin/rserver --server-daemonize 0
