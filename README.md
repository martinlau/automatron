Automatron
==========

An end to end configuration of:

* [VMware][vmware] and [VirtualBox][virtualbox] for running virtual machines
* [Packer][packer] for provisioning base operating system onto those virtual machines
* [Vagrant][vagrant] for provisioning [Packer][packer] built instances into a development environment
* [Puppet][puppet] and [Chef][chef] for provisioning the application platform within that environment
* and more to come to build code, deploy, run tests, etc...


Pre-requisites
--------------

You'll need to download either [VMWare][vmware] or [VirtualBox][virtualbox] to get started (you can try running both but don't complain if things get messy).

You'll need to download and install [Packer][packer] to build the virtual machine images.

You'll need to download and install [Vagrant][vagrant] to provision the systems.

Running
-------

Depending on which virtual machine you're using, you'll need to run something like the following (possibly replacing `vmware-iso` with `virtualbox-iso`).

```

packer build --only=vmware-iso fedora-20-x86_64.json

```

Don't hold your breath, it'll take a while to download the relevant ISO's, do the installation and compress the VM image. The output should look something like the following (which has had a lot of noise removed):

```

vmware-iso output will be in this color.

==> vmware-iso: Downloading or copying ISO
    vmware-iso: Downloading or copying: http://mirror.optus.net/pub/fedora/linux/releases/20/Fedora/x86_64/iso/Fedora-20-x86_64-netinst.iso
==> vmware-iso: Creating virtual machine disk
==> vmware-iso: Building and writing VMX file
==> vmware-iso: Starting HTTP server on port 8198
==> vmware-iso: Starting virtual machine...
==> vmware-iso: Waiting 15s for boot...
==> vmware-iso: Connecting to VM via VNC
==> vmware-iso: Typing the boot command over VNC...
==> vmware-iso: Waiting for SSH to become available...
==> vmware-iso: Connected to SSH!
==> vmware-iso: Uploading the 'linux' VMware Tools
==> vmware-iso: Provisioning with shell script: script/01_update.sh
    vmware-iso: Running yum update
    ...
    vmware-iso: Sleeping to prevent packer from running the next script
==> vmware-iso: Provisioning with shell script: script/20_udev.sh
    vmware-iso: Removing HWADDR lines under /etc/sysconfig/network-scripts
    ...
    vmware-iso: Checking for HWADDR in /etc/sysconfig/network-scripts/ifcfg-lo
==> vmware-iso: Provisioning with shell script: script/21_sshd.sh
    vmware-iso: Forcing UseDNS in /etc/ssh/sshd_config
==> vmware-iso: Provisioning with shell script: script/40_vmtools.sh
    vmware-iso: Installing virtual machine tools for vmware-iso
    ...
    vmware-iso: Cleaning up /home/vagrant/linux.iso and /tmp/vmware
==> vmware-iso: Provisioning with shell script: script/60_vagrant.sh
    vmware-iso: Creating ~vagrant/.ssh
    ...
    vmware-iso: Setting ~vagrant/.ssh permissions and ownership
==> vmware-iso: Provisioning with shell script: script/61_chef.sh
    vmware-iso: Installing chef from https://www.opscode.com/chef/install.sh
    ...
    vmware-iso: Thank you for installing Chef!
==> vmware-iso: Provisioning with shell script: script/62_puppet.sh
    vmware-iso: Adding puppet repository from https://yum.puppetlabs.com/fedora/f20/products/x86_64/puppetlabs-release-20-1.noarch.rpm
    ...
    vmware-iso: Complete!
==> vmware-iso: Provisioning with shell script: script/98_cleanup.sh
    vmware-iso: Running yum clean
    ...
    vmware-iso: Clearing out /tmp and /var
==> vmware-iso: Provisioning with shell script: script/99_zero.sh
    vmware-iso: Zeroing free space on the root file system
    ...
    vmware-iso: Syncing disks
==> vmware-iso: Gracefully halting virtual machine...
    vmware-iso: Waiting for VMware to clean up after itself...
==> vmware-iso: Deleting unnecessary VMware files...
    vmware-iso: Deleting: output-vmware-iso/564df148-71c0-1fe2-f34c-0b23ff0fa1d6.vmem
    ...
    vmware-iso: Deleting: output-vmware-iso/vmware.log
==> vmware-iso: Cleaning VMX prior to finishing up...
    vmware-iso: Detaching ISO from CD-ROM device...
==> vmware-iso: Compacting the disk image
==> vmware-iso: Running post-processor: vagrant
==> vmware-iso (vagrant): Creating Vagrant box for 'vmware' provider
    vmware-iso (vagrant): Copying: output-vmware-iso/fedora-20-x86_64-s001.vmdk
    ...
    vmware-iso (vagrant): Compressing: startMenu.plist

Build 'vmware-iso' finished.

==> Builds finished. The artifacts of successful builds are:
--> vmware-iso: VM files in directory: output-vmware-iso
--> vmware-iso: 'vmware' provider box: ../../boxes/vmware/fedora-20-x86_64.box

```

At this point, you should have a .box image which you can boot [Vagrant][vagrant] from:

```

 $ ls -l ../../boxes/vmware/
total 2026440
-rw-r--r--  1 martin  staff          0 13 Feb 13:11 empty.txt
-rw-r--r--  1 martin  staff  551650917 14 Feb 14:08 fedora-20-x86_64.box

```

Which you can then use with [Vagrant][vagrant] (again, replacing `vmware_fusion` with `virtualbox` as necessary):

```

 $ vagrant up --provider vmware_fusion
Bringing machine 'default' up with 'vmware_fusion' provider...
[default] Cloning VMware VM: 'fedora-20-x86_64'. This can take some time...
[default] Verifying vmnet devices are healthy...
[default] Preparing network adapters...
[default] Starting the VMware VM...
[default] Waiting for the VM to finish booting...
[default] The machine is booted and ready!
[default] Forwarding ports...
[default] -- 22 => 2222
[default] Configuring network adapters within the VM...
[default] Waiting for HGFS kernel module to load...
[default] Enabling and configuring shared folders...
[default] -- /Users/martin/Projects/Packer/vagrant/fedora: /vagrant

 $ vagrant ssh
Last login: Thu Feb 13 22:33:46 2014 from 192.168.2.1

[vagrant@fedora-vagrant ~]$ whoami
vagrant

[vagrant@fedora-vagrant ~]$ hostname
fedora-vagrant.local

[vagrant@fedora-vagrant ~]$ exit
logout
Connection to 192.168.2.137 closed.

 $ vagrant destroy
Are you sure you want to destroy the 'default' VM? [y/N] y
[default] Stopping the VMware VM...
[default] Deleting the VM...

```

[vmware]: http://www.vmware.com "VMware"
[virtualbox]: http://www.virtualbox.org "Virtualbox"
[packer]: http://www.packer.io "Packer"
[vagrant]: http://www.vagrantup.com "Vagrant"
[puppet]: http://puppetlabs.com "Puppet"
[chef]: http://www.getchef.com "Chef"
