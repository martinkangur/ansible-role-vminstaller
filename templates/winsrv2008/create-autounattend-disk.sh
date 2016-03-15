#!/bin/sh

VIRTDIR="{{ virtualfilespath }}"
USBDRIVE="{{ inventory_hostname }}-autounattend-disk.vusb"
XMLFILE="{{ inventory_hostname }}-autounattend.xml"
PS0SCRIPT="{{ inventory_hostname }}-PowerShellUpgradeTo3.ps1"
PS1SCRIPT="{{ inventory_hostname }}-ConfigureRemotingForAnsible.ps1"
TMPDIR="/tmp/"
MOUNTDIR="/mnt/"

if [[ ! -e $VIRTDIR$USBDRIVE ]]; then
    rm -rf $VIRTDIR$USBDRIVE
fi

dd if=/dev/zero of=$VIRTDIR$USBDRIVE bs=1k count=1440
mkfs.vfat $VIRTDIR$USBDRIVE
mount -o loop -t vfat $VIRTDIR$USBDRIVE $MOUNTDIR
cp $VIRTDIR$XMLFILE $MOUNTDIR"Autounattend.xml"
cp $VIRTDIR$PS0SCRIPT $MOUNTDIR"PowerShellUpgradeTo3.ps1"
cp $VIRTDIR$PS1SCRIPT $MOUNTDIR"ConfigureRemotingForAnsible.ps1"
umount $VIRTDIR$USBDRIVE
