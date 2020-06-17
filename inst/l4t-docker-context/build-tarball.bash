#! /bin/bash

/usr/bin/time sudo docker build --tag=znmeb/tarball:latest --file=Dockerfile.tarball .
sudo docker push znmeb/tarball:latest
sudo docker images
