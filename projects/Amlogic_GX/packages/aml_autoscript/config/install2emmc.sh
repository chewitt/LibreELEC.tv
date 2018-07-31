#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

BACKUP_DATE=$(date +%Y%m%d%H%M%S)

IMAGE_KERNEL="/flash/Image"
IMAGE_SYSTEM="/flash/SYSTEM"
IMAGE_DTB="/flash/dtb.img"
SCRIPT_EMMC="/flash/boot.scr"
SCRIPT_ENV="/flash/emmc_uEnv.ini"
IMAGE_UBOOT="/flash/u-boot-2018-vim-emmc.img"

install_to_emmc() {
  if [ -f $IMAGE_KERNEL -a -f $IMAGE_SYSTEM -a -f $SCRIPT_EMMC -a -f $SCRIPT_ENV -a -f $IMAGE_UBOOT ] ; then

    mount -o rw,remount /flash
    echo -n "Backing up bootloader..."
    dd if=/dev/mmcblk1 of="/flash/bootloader_$BACKUP_DATE.img" bs=1M count=4 conv=fsync 2> /dev/null
    echo "done."

    echo -n "Write newq bootloader..."
    dd if=$IMAGE_UBOOT of=/dev/mmcblk1 bs=1M count=4 conv=fsync 2> /dev/null
    echo "done."

    if grep -q /dev/mmcblk1p1 /proc/mounts ; then
        echo "Unmounting SYSTEM partiton."
        umount -f /dev/mmcblk1p1
    fi
    echo -n "Formatting SYSTEM partition..."
    mkfs.vfat -n "LE_EMMC" /dev/mmcblk1p1 || exit 1
    echo "done."

    mkdir -p /tmp/system
    mount /dev/mmcblk1p1 /tmp/system

    if grep -q /dev/mmcblk1p1 /proc/mounts ; then

        echo -n "Cppying kernel image..."
        cp $IMAGE_KERNEL /tmp/system && sync
        echo "done."

        echo -n "Copying SYSTEM files..."
        cp $IMAGE_SYSTEM /tmp/system && sync
        echo "done."

        echo -n "Writing script eMMC..."
        cp $SCRIPT_EMMC /tmp/system && sync
        echo "done."

        echo -n "Writing init ENV..."
        cp $SCRIPT_ENV /tmp/system && sync
        echo "done."

        if [ -f $IMAGE_DTB ] ; then
          echo -n "Writing device tree image..."
          cp $IMAGE_DTB /tmp/system && sync
          echo "done."
        fi

        umount /tmp/system

	if grep -q /dev/mmcblk1p2 /proc/mounts ; then
	    echo "Unmounting DATA partiton."
	    umount -f /dev/mmcblk1p2
	fi
	
	echo -n "Formatting DATA partition..."
        mke2fs -F -q -t ext4 -m 0 /dev/mmcblk1p2 || exit 1
        e2fsck -n /dev/mmcblk1p2 || exit 1
	echo "done."
	
        mkdir -p /tmp/data
        mount -o rw /dev/mmcblk1p2 /tmp/data
	echo "" > /tmp/data/.please_resize_me
        umount /tmp/data

	sync

	echo "All done!"
        echo "WARNING: If your internal memory layout is different from standard Amlogic, you have to perform this operation again!"
        echo "Poweroff Your system, remove media will run from internal memory."
        echo ""

    else
      echo "No /dev/mmcblk1p1  partiton."
    fi

  else
    echo "No LE image found on /flash! Exiting..."
  fi
}

echo "This script will erase BOOT, SYSTEM, DATA and DTB on your device"
echo "and install LE that you booted from SD card/USB drive."
echo ""
echo "It will create a backup of bootloader on your boot media."
echo ""
echo "The script does not have any safeguards!"
echo ""

#read -p "Type \"yes\" if you know what you are doing or anything else to exit: " choice
#case "$choice" in
#  yes) 
install_to_emmc
# ;;
#esac
