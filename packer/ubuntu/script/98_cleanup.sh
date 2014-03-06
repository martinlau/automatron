#!/bin/bash -eux

echo "Running apt-get clean"
apt-get clean

echo "Clearing out /tmp and /var"
rm -rf /tmp/* \
       /var/tmp/*
