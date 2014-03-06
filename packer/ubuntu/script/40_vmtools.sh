#!/bin/bash -eux

ISO_MOUNT="/media"
VIRTUALBOX_LINUX_ADDITIONS="${ISO_MOUNT}/VBoxLinuxAdditions.run"
VIRTUALBOX_REQUIRED_PACKAGES="build-essentials"
VMWARE_INSTALL_PL="/tmp/vmware/vmware-tools-distrib/vmware-install.pl"
VMWARE_REQUIRED_PACKAGES="build-essentials"
VMWARE_TOOLS_TMP="/tmp/vmware"

echo "Installing virtual machine tools for ${PACKER_BUILDER_TYPE}"
if [[ ${PACKER_BUILDER_TYPE} =~ vmware ]]
then

    echo "Installing VMWare Tools required packages ${VMWARE_REQUIRED_PACKAGES}"
    apt-get install -y ${VMWARE_REQUIRED_PACKAGES}

    echo "Mounting ${VMWARE_TOOLS_ISO} onto ${ISO_MOUNT}"
    mount -o loop ${VMWARE_TOOLS_ISO} ${ISO_MOUNT}

    echo "Extracting VMWare Tools to /tmp/vmware"
    mkdir -p ${VMWARE_TOOLS_TMP}

    echo "Extracting ${ISO_MOUNT}/VMwareTools-*.tar.gz to ${VMWARE_TOOLS_TMP}"
    tar xzf ${ISO_MOUNT}/VMwareTools-*.tar.gz -C ${VMWARE_TOOLS_TMP}

    echo "Unmounting ${VMWARE_TOOLS_ISO} from ${ISO_MOUNT}"
    umount ${ISO_MOUNT}

    echo "Running ${VMWARE_INSTALL_PL}"
    ${VMWARE_INSTALL_PL} -d

    echo "Cleaning up ${VMWARE_TOOLS_ISO} and ${VMWARE_TOOLS_TMP}"
    rm ${VMWARE_TOOLS_ISO}
    rm -rf ${VMWARE_TOOLS_TMP}

elif [[ ${PACKER_BUILDER_TYPE} =~ virtualbox ]]
then

    echo "Installing VirtualBox Additions required packages ${VIRTUALBOX_REQUIRED_PACKAGES}"
    apt-get install -y ${VIRTUALBOX_REQUIRED_PACKAGES}

    echo "Mounting ${VIRTUALBOX_ADDITIONS_ISO} onto ${ISO_MOUNT}"
    mount -o loop ${VIRTUALBOX_ADDITIONS_ISO} ${ISO_MOUNT}

    echo "Running ${VIRTUALBOX_LINUX_ADDITIONS}"
    sh ${VIRTUALBOX_LINUX_ADDITIONS} --nox11

    echo "Unmounting ${VIRTUALBOX_ADDITIONS_ISO} from ${ISO_MOUNT}"
    umount ${ISO_MOUNT}

    echo "Cleaing up ${VIRTUALBOX_ADDITIONS_ISO}"
    rm ${VIRTUALBOX_ADDITIONS_ISO}

else

    echo "Unknown builder ${PACKER_BUILDER_TYPE}"
    exit -1

fi
