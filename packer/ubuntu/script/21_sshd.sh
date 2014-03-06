#!/bin/bash -eux

SSHD_CONFIG_PATH=/etc/ssh/sshd_config

if grep -q 'UseDNS' ${SSHD_CONFIG_PATH}
then
    echo "Forcing UseDNS in ${SSHD_CONFIG_PATH}"
    sed -i 's/.*UseDNS.*/UseDNS no/' ${SSHD_CONFIG_PATH}
else
    echo "Disabling UseDNS in ${SSHD_CONFIG_PATH}"
    echo "UseDNS no" >> ${SSHD_CONFIG_PATH}
fi
