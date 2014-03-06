#!/bin/bash -eux

PUPPET_DEB_FILE=`echo ${PUPPET_REPOSITORY_DEB} | awk -F/ '{ print $NF }'`

if [[ ${PUPPET_INSTALL} =~ true ]]
then

    echo "Downloading puppet repository from ${PUPPET_REPOSITORY_DEB}"
    wget ${PUPPET_REPOSITORY_DEB}

    echo "Installing puppet repository from ${PUPPET_DEB_FILE}"
    dpkg -i ${PUPPET_DEB_FILE}

    echo "Running apt-get update"
    apt-get update -y

    echo "Running apt-get install puppet"
    apt-get install -y puppet

    echo "Removing ${PUPPET_DEB_FILE}"
    rm ${PUPPET_DEB_FILE}

else
    echo "Skipping puppet install"
fi
