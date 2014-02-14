#!/bin/bash -eux

echo "Disabling KDump (VM has insufficient memory)"
chkconfig kdump off
