#!/bin/bash -eux

SWAP_UUID=`cat /etc/fstab | grep swap | grep UUID | awk '{ print $1 }' | cut -d = -f 2`
SWAP_DEVICE=`swapon -s | tail -1 | awk '{ print $1 }'`

echo "Zeroing free space on the root file system"
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

echo "Turning off swap device ${SWAP_DEVICE}"
swapoff ${SWAP_DEVICE}

echo "Zeroing swap sapce ${SWAP_DEVICE}"
dd if=/dev/zero of=${SWAP_DEVICE} bs=1M

echo "Recreating swap device ${SWAP_DEVICE} with UUID ${SWAP_UUID}"
mkswap ${SWAP_DEVICE} --uuid ${SWAP_UUID}

echo "Syncing disks"
sleep 1
sync
