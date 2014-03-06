#!/bin/bash -eux

echo "Running apt-get update"
apt-get update -y

echo "Rebooting"
reboot

echo "Sleeping to prevent packer from running the next script"
sleep 10
