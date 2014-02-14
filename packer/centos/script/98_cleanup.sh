#!/bin/bash -eux

echo "Running yum clean"
yum -y clean all

echo "Clearing out /tmp and /var"
rm -rf /tmp/* \
       /var/cache/* \
       /var/tmp/*
