# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

# allow upgrades between arm and aarch64 images

if [ "$1" = "Odroid_N2.aarch64" -o "$1" = "Odroid_N2.arm" ]; then
  exit 0
else
  exit 1
fi
