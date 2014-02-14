#!/bin/bash -eux

if [[ ${PUPPET_INSTALL} =~ true ]]
then

    echo "Adding puppet repository from ${PUPPET_REPOSITORY_RPM}"
    rpm -ivh ${PUPPET_REPOSITORY_RPM}

    echo "Running yum install puppet"
    yum -y install puppet

else
    echo "Skipping puppet install"
fi
