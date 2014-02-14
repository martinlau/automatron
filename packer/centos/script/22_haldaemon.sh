#!/bin/bash -eux

echo "Disabling HAL daemon (would be good to know why it fails though)"
chkconfig haldaemon off
