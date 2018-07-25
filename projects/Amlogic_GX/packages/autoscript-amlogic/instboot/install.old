#!/bin/sh

################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

IMAGE_KERNEL="/flash/kernel.img"
IMAGE_SYSTEM="/flash/SYSTEM"
IMAGE_DTB="/flash/dtb.img"
#REMOTE_CONF="/tmp/remote.conf"

install_to_nand() {
  if [ -f $IMAGE_KERNEL -a -f $IMAGE_SYSTEM ] ; then

    if grep -q /dev/system /proc/mounts ; then
      echo "Unmounting SYSTEM partiton."
      umount -f /dev/system
    fi
    mkdir -p /tmp/system

    mount -o rw,remount /flash
    if [ -e /dev/dtb ] ; then
      echo -n "Backing up device tree..."
      dd if="/dev/dtb" of="/flash/dtb.img.backup" status=none && sync
      echo "done."
    fi

    if [ -e /dev/recovery ] ; then
      echo -n "Backing up recovery partition..."
      dd if="/dev/recovery" of="/flash/recovery.img.backup" bs=64K status=none && sync
      echo "done."
    fi

#    if [ ! -f $REMOTE_CONF ] ; then
#      echo -n "Backing up remote.conf..."
#      mount -o ro /dev/system /tmp/system
#      if [ -f /tmp/system/remote.conf ]; then
#        cp /tmp/system/remote.conf /tmp/remote.conf
#      elif [ -f /tmp/system/etc/remote.conf ]; then
#        cp -PR /tmp/system/etc/remote.conf /tmp/remote.conf
#      fi
#      umount /tmp/system
#      echo "done."
#    fi

    echo -n "Writing kernel image..."
    dd if="$IMAGE_KERNEL" of="/dev/boot" bs=64K status=none && sync
    echo "done."

    echo -n "Formatting SYSTEM partition..."
    mke2fs -F -q -t ext4 -m 0 /dev/system > /dev/null
    e2fsck -n /dev/system &> /dev/null
    echo "done."

    echo -n "Copying SYSTEM files..."
    mount -o rw /dev/system /tmp/system
    cp $IMAGE_SYSTEM /tmp/system && sync
    umount /tmp/system
    echo "done."

    if [ -f $IMAGE_DTB ] ; then
      echo -n "Writing device tree image..."
      dd if="$IMAGE_DTB" of="/dev/dtb" bs=262144 status=none && sync
      echo "done."
    fi

    echo -n "Formatting DATA partition..."
    mke2fs -F -q -t ext4 -m 0 /dev/data > /dev/null
    e2fsck -n /dev/data &> /dev/null
    echo "done."

#    if [ -f /flash/remote.conf ] ; then
#      echo -n "Restoring remote.conf in /flash ..."
#      mount -o rw /dev/system /tmp/system
#      cp /flash/remote.conf /tmp/system/remote.conf
#      umount /tmp/system
#      echo "done."
#    else
#      if [ -f $REMOTE_CONF ] ; then
#        echo -n "Restoring remote.conf in /tmp ..."
#        mount -o rw /dev/system /tmp/system
#        cp $REMOTE_CONF /tmp/system/remote.conf
#        umount /tmp/system
#        echo "done."
#      fi
#   fi

#    echo "Copying user data..."
#    mkdir -p /tmp/data
#    mount -o rw /dev/data /tmp/data
#    cp -av /storage/. /tmp/data/
#    echo "done."

  else
    echo "No LE image found on /flash! Exiting..."
  fi
}

echo "This script will erase BOOT, SYSTEM, DATA and DTB on your device"
echo "and install LE that you booted from SD card/USB drive."
echo ""
echo "It will create a backup of device tree and recovery partition on your boot media."
echo ""
echo "The script does not have any safeguards!"
echo ""

install_to_nand

sleep 20
