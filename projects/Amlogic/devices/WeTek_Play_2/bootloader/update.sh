# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

[ -z "$SYSTEM_ROOT" ] && SYSTEM_ROOT=""
[ -z "$BOOT_ROOT" ] && BOOT_ROOT="/flash"
[ -z "$BOOT_PART" ] && BOOT_PART=$(df "$BOOT_ROOT" | tail -1 | awk {' print $1 '})

# identify the boot device
  if [ -z "$BOOT_DISK" ]; then
    case $BOOT_PART in
      /dev/sd[a-z][0-9]*)
        BOOT_DISK=$(echo $BOOT_PART | sed -e "s,[0-9]*,,g")
        ;;
      /dev/mmcblk*)
        BOOT_DISK=$(echo $BOOT_PART | sed -e "s,p[0-9]*,,g")
        ;;
    esac
  fi

# mount $BOOT_ROOT r/w
  mount -o remount,rw $BOOT_ROOT

# update device tree
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/dtb.img ]; then
    echo "Updating dtb.img"
    cp -p $SYSTEM_ROOT/usr/share/bootloader/dtb.img $BOOT_ROOT
  fi

# update aml_autoscript
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/aml_autoscript ]; then
    echo "Updating aml_autoscript"
    cp -p $SYSTEM_ROOT/usr/share/bootloader/aml_autoscript $BOOT_ROOT
  fi

# update emmc_autoscript
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/emmc_autoscript ]; then
    echo "Updating emmc_autoscript"
    cp -p $SYSTEM_ROOT/usr/share/bootloader/emmc_autoscript $BOOT_ROOT
  fi

# update s905_autoscript
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/s905_autoscript ]; then
    echo "Updating s905_autoscript"
    cp -p $SYSTEM_ROOT/usr/share/bootloader/s905_autoscript $BOOT_ROOT
  fi

# update aml_autoscript.zip
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/aml_autoscript.zip ]; then
    echo "Updating aml_autoscript.zip"
    cp -p $SYSTEM_ROOT/usr/share/bootloader/aml_autoscript.zip $BOOT_ROOT
  fi

# update uEnv.ini
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/uEnv.ini ]; then
    echo "Updating uEnv.ini"
    cp -p $SYSTEM_ROOT/usr/share/bootloader/uEnv.ini $BOOT_ROOT
  fi

# update emmc-uEnv.ini
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/emmc-uEnv.ini ]; then
    echo "Updating emmc-uEnv.ini"
    cp -p $SYSTEM_ROOT/usr/share/bootloader/emmc-uEnv.ini $BOOT_ROOT
  fi

# mount $BOOT_ROOT r/o
  sync
  mount -o remount,ro $BOOT_ROOT
