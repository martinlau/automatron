#!/bin/bash -eux

echo "Running yum update"
yum update -y

echo "Rebooting"
reboot

echo "Sleeping to prevent packer from running the next script"
sleep 10
