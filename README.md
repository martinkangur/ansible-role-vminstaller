Ansible Role : VMINSTALLER
===========================

This ansible role is for installing virtual machines using ansible with libvirt.

The role presumes you have an hypervisor running Linux with KVM and Libvirt.
It uses virt-install to execute the installation of the VM.
The role can deply to multiple architectures and distributions.


### Dependencies ###

*   Ansible (on the management node)
*   Libvirt with python modules including the virt-install tool
*   Access to the Linux Distribution Repositories (on the hypervisor)


### Architectures ###

The role is currently supported for :
* x86_64
* powerpc (ppc64,ppc64le,ppc64le,powerpc)


### Distributions ###

Currently working distributions that have been tested (in a limited capacity):

* CentOS
    - CentOS6
    - CentOS7
* Red Hat
    - RHEL6
    - RHEL7
* PowerEL
    - PEL7
* Scientific Linux
    - SL6
    - SL7
* Debian :
    - debian7
    - debian8
* MS Windows
    - WinSrv2008(r2)
    - WinSrv2012(r2)


### Work In Progress ###

The role is being worked on for the following distros :

* Ubuntu (automated install problem, with both preseed as wel as kickstart based)
* FreeBSD (works in some cases)
* OpenBSD (works in some cases)
* Windows 7 Pro / Windows 10 Pro (VDI, requires better graphics support)


### Authors ###

-   Toshaan Bharvani - <toshaan@vantosh.com> - (http://www.vantosh.com)

