# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

# allow upgrades between older Q200 and S912 images

if [ "$1" = "Q200.aarch64" -o "$1" = "Q200.arm" -o "$1" = "S912.arm" ]; then
  exit 0
else
  exit 1
fi
