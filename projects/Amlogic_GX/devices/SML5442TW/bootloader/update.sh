#!/bin/sh
################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018 Team LibreELEC
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

[ -z "$SYSTEM_ROOT" ] && SYSTEM_ROOT=""
[ -z "$BOOT_ROOT" ] && BOOT_ROOT="/flash"

if [ -f $SYSTEM_ROOT/usr/share/bootloader/dtb.img ]; then
  mount -o remount,rw $BOOT_ROOT
  cp -p $SYSTEM_ROOT/usr/share/bootloader/dtb.img $BOOT_ROOT
  sync
  mount -o remount,ro $BOOT_ROOT
fi
