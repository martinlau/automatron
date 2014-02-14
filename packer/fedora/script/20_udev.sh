#!/bin/bash -eux

IFCFG_PATH=/etc/sysconfig/network-scripts

echo "Removing HWADDR lines under ${IFCFG_PATH}"

for FILE in ${IFCFG_PATH}/ifcfg-*
do
    echo "Checking for HWADDR in ${FILE}"
    if grep -q HWADDR ${FILE}
    then
        echo "Removing HWADDR from ${FILE}"
        sed -ri '/^HWADDR/d' ${FILE}
    fi
done

if [[ -f /etc/udev/rule.d/70-persistent-net.rules ]]
then
    echo "Removing /etc/udev/rule.d/70-persistent-net.rules"
    rm /etc/udev/rule.d/70-persistent-net.rules

    echo "Symlinking /dev/null over /etc/udev/rule.d/70-persistent-net.rules"
    ln -s /dev/null /etc/udev/rule.d/70-persistent-net.rules
fi
