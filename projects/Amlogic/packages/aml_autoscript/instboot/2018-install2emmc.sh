#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

BACKUP_DATE=$(date +%Y%m%d%H%M%S)
DEV_EMMC="/dev/mmcblk1"

IMAGE_UBOOT="/flash/uboot.img"

if [ -f $IMAGE_UBOOT ] ; then
    mount -o rw,remount /flash
    dd if="${DEV_EMMC}" of="/flash/bootloader_$BACKUP_DATE.img" bs=1M count=4 conv=fsync 2> /dev/null
    dd if=$IMAGE_UBOOT of="${DEV_EMMC}" conv=fsync 2> /dev/null
    rm -f $IMAGE_UBOOT
else
    echo  "Not found new bootloader..."
    exit 1
fi

dd if="${DEV_EMMC}" of=/flash/u-boot-default.img bs=1M count=4

if grep -q "${DEV_EMMC}p1" /proc/mounts ; then
    umount -f "${DEV_EMMC}p1"
fi

if grep -q "${DEV_EMMC}p2" /proc/mounts ; then
    umount -f "${DEV_EMMC}p1"
fi

parted -s "${DEV_EMMC}" mklabel msdos
parted -s "${DEV_EMMC}" mkpart primary fat32 4M 516M
parted -s "${DEV_EMMC}" mkpart primary ext4 517M 549M

dd if=/flash/u-boot-default.img of="${DEV_EMMC}" conv=fsync bs=1 count=442
dd if=/flash/u-boot-default.img of="${DEV_EMMC}" conv=fsync bs=512 skip=1 seek=1

sync

IMAGE_KERNEL="/flash/Image"
IMAGE_SYSTEM="/flash/SYSTEM"
SCRIPT_ENV="/flash/extlinux/extlinux.conf"
IMAGE_DTB="/flash/dtb"

if [ -f $IMAGE_KERNEL -a -f $IMAGE_SYSTEM -f $SCRIPT_ENV ] ; then

    if grep -q "${DEV_EMMC}p1" /proc/mounts ; then
      umount -f "${DEV_EMMC}p1"
    fi
    mkfs.vfat -n "LE_EMMC" "${DEV_EMMC}p1"

    mkdir -p /tmp/system
    mount "${DEV_EMMC}p1" /tmp/system

    if grep -q "${DEV_EMMC}p1" /proc/mounts ; then

        cp $IMAGE_KERNEL /tmp/system && sync
        cp $IMAGE_SYSTEM /tmp/system && sync
        mkdir /tmp/system/extlinux
        cp $SCRIPT_ENV /tmp/system/extlinux && sync
        sed -e "s/LIBREELEC/LE_EMMC/g" \
          -e "s/STORAGE/DATA_EMMC/g" \
          -i "/tmp/system/extlinux/extlinux.conf"

        cp -r $IMAGE_DTB /tmp/system && sync
        umount /tmp/system

	if grep -q "${DEV_EMMC}p2" /proc/mounts ; then
	    umount -f "${DEV_EMMC}p2"
	fi
	
        mkfs.ext4 -F -L DATA_EMMC "${DEV_EMMC}p2"
        e2fsck -n "${DEV_EMMC}p2"
	
        mkdir -p /tmp/data
        mount -o rw "${DEV_EMMC}p2" /tmp/data
	echo "" > /tmp/data/.please_resize_me
        umount /tmp/data

	sync
        poweroff
        exit 0
    else
      echo "No $DEV_EMMC partiton."
      exit 1
    fi
else
    echo "No LE image found on /flash! Exiting..."
    exit 1
fi
