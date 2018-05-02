#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

IMAGE_KERNEL="/flash/kernel.img"
IMAGE_SYSTEM="/flash/SYSTEM"
IMAGE_DTB="/flash/dtb.img"
SCRIPT_EMMC="/flash/emmc_autoscript"
SCRIPT_ENV="/flash/emmc_uEnv.ini"

install_emmc() {
  if [ -f $IMAGE_KERNEL -a -f $IMAGE_SYSTEM -a -f $SCRIPT_EMMC ]; then

    echo "Unmounting SYSTEM partiton..."
    umount -f /dev/system
    mkdir -p /tmp/system
    mount -o rw /dev/system /tmp/system

    if grep -q /dev/system /proc/mounts; then

      echo -n "Copying kernel.img..."
      cp $IMAGE_KERNEL /tmp/system && sync
      echo -n "Copying SYSTEM..."
      cp $IMAGE_SYSTEM /tmp/system && sync
      echo -n "Copying emmc_autoscript..."
      cp $SCRIPT_EMMC /tmp/system && sync
      if [ -f $IMAGE_DTB ]; then
        echo -n "Copying dtb.img..."
        cp $IMAGE_DTB /tmp/system && sync
      fi
      if [ -f $SCRIPT_ENV ] ; then
        echo -n "Copying emmc_uEnv.ini..."
        cp $SCRIPT_ENV /tmp/system && sync
      fi
      umount /tmp/system

    else
      echo "error: no /dev/system partiton!"
      sleep 10
    fi

  else
    echo "error: no LibreELEC files on /flash!"
    sleep 10
  fi
}

echo "This script installs LibreELEC, overwriting the eMMC storage area!"
echo ""

install_emmc
sleep 10
