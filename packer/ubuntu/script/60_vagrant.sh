#!/bin/bash -eux

echo "Creating ~vagrant/.ssh"
mkdir -p /home/vagrant/.ssh

echo "Fetching public key from ${VAGRANT_PUBLIC_KEY}"
curl -o /home/vagrant/.ssh/authorized_keys ${VAGRANT_PUBLIC_KEY}

echo "Setting ~vagrant/.ssh permissions and ownership"
chown vagrant:vagrant -R /home/vagrant/.ssh
chmod 0700 /home/vagrant/.ssh
chmod 0600 /home/vagrant/.ssh/authorized_keys
