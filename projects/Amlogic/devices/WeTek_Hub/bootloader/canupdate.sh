
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

# prevent upgrades from 3.14 kernel images

if [ "$1" = "WeTek_Hub.aarch64" -o "$1" = "S905.arm" ]; then
  echo ""
  echo "It is not possible to update from older LibreELEC images due to"
  echo "boot changes in the Linux kernel. Please backup, clean install,"
  echo "then restore from backup."
  exit 1
fi
