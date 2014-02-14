#!/bin/bash -eux

SWAP_DEVICE=`swapon -s | tail -1 | awk '{ print $1 }'`

echo "Zeroing free space on the root file system"
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

echo "Zeroing free space on the boot file system"
dd if=/dev/zero of=/boot/EMPTY bs=1M
rm -f /boot/EMPTY

echo "Turning off swap device ${SWAP_DEVICE}"
swapoff ${SWAP_DEVICE}

echo "Zeroing swap sapce ${SWAP_DEVICE}"
dd if=/dev/zero of=${SWAP_DEVICE} bs=1M

echo "Recreating swap device ${SWAP_DEVICE}"
mkswap ${SWAP_DEVICE}

echo "Syncing disks"
sleep 1
sync
