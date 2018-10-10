#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

BACKUP_DATE=$(date +%Y%m%d%H%M%S)

IMAGE_UBOOT="/flash/u-boot-emmc.img"

if [ -f $IMAGE_UBOOT ] ; then

    mount -o rw,remount /flash

    echo -n "Backing up bootloader..."
    dd if=/dev/mmcblk1 of="/flash/bootloader_$BACKUP_DATE.img" bs=1M count=4 conv=fsync 2> /dev/null
    echo "done."

    echo -n "Write new bootloader..."
    dd if=$IMAGE_UBOOT of=/dev/mmcblk1 conv=fsync 2> /dev/null
    rm -f $IMAGE_UBOOT
    echo "done."
    exit 0
else
    echo  "Not found new bootloader..."
    exit 1
fi
