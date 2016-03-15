#!/bin/sh

VIRTDIR="{{ virtualfilespath }}"
USBDRIVE="{{ inventory_hostname }}-autounattend-disk.vusb"
XMLFILE="{{ inventory_hostname }}-autounattend.xml"
PS1SCRIPT="{{ inventory_hostname}}-ConfigureRemotingForAnsible.ps1"
TMPDIR="/tmp/"
MOUNTDIR="/mnt/"

if [[ ! -e $VIRTDIR$USBDRIVE ]]; then
    rm -rf $VIRTDIR$USBDRIVE
fi

dd if=/dev/zero of=$VIRTDIR$USBDRIVE bs=1k count=1440
mkfs.vfat $VIRTDIR$USBDRIVE
mount -o loop -t vfat $VIRTDIR$USBDRIVE $MOUNTDIR
cp $VIRTDIR$XMLFILE $MOUNTDIR"Autounattend.xml"
cp $VIRTDIR$PS1SCRIPT $MOUNTDIR"ConfigureRemotingForAnsible.ps1"
umount $VIRTDIR$USBDRIVE
