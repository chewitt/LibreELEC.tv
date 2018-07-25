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
#IMAGE_KERNEL="/flash/Image"
IMAGE_SYSTEM="/flash/SYSTEM"
IMAGE_DTB="/flash/dtb.img"
SCRIPT_EMMC="/flash/emmc_autoscript"
SCRIPT_ENV="/flash/emmc_uEnv.ini"

install_to_emmc() {
  if [ -f $IMAGE_KERNEL -a -f $IMAGE_SYSTEM -a -f $SCRIPT_EMMC ] ; then

	echo "Unmounting SYSTEM partiton."
	umount -f /dev/system
        mkdir -p /tmp/system
        mount -o rw /dev/system /tmp/system

    if grep -q /dev/system /proc/mounts ; then

        echo -n "Cppying kernel image..."
        cp $IMAGE_KERNEL /tmp/system && sync
        echo "done."

        echo -n "Copying SYSTEM files..."
        cp $IMAGE_SYSTEM /tmp/system && sync
        echo "done."

        echo -n "Writing script eMMC..."
        cp $SCRIPT_EMMC /tmp/system && sync
        echo "done."

        if [ -f $IMAGE_DTB ] ; then
          echo -n "Writing device tree image..."
          cp $IMAGE_DTB /tmp/system && sync
          echo "done."
        fi

        if [ -f $SCRIPT_ENV ] ; then
          echo -n "Writing init ENV..."
          cp $SCRIPT_ENV /tmp/system && sync
          echo "done."
        fi

        umount /tmp/system

    else
      echo "No /dev/system  partiton."
      sleep 10
    fi

  else
    echo "No LE image found on /flash! Exiting..."
    sleep 10
  fi
}

echo "This script install LE that you booted from SD card/USB drive."
echo ""
echo "The script does not have any safeguards!"
echo ""

install_to_emmc

sleep 10
