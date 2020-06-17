#! /bin/bash

useradd -r rstudio-server
ln -f -s /usr/local/lib/rstudio-server/bin/rstudio-server /usr/sbin/rstudio-server
mkdir -p /var/run/rstudio-server
mkdir -p /var/lock/rstudio-server
mkdir -p /var/log/rstudio-server
mkdir -p /var/lib/rstudio-server
mkdir -p /etc/rstudio

# see https://support.rstudio.com/hc/en-us/articles/200552316-Configuring-the-Server
cp rserver.conf /etc/rstudio/
