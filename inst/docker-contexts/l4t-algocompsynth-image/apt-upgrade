#! /bin/bash

echo "Upgrading NVIDIA base"
apt-get update
apt-get install -qqy --no-install-recommends time tzdata bash-completion
/usr/bin/time apt-get upgrade -y

echo "Cleanup"
apt-get autoremove --purge -y
apt-get clean
