#!/bin/bash -eux

if [[ ${CHEF_INSTALL} =~ true ]]
then

    echo "Installing chef from ${CHEF_INSTALL_URL}"
    curl -L ${CHEF_INSTALL_URL} | bash

else
    echo "Skipping chef install"
fi
