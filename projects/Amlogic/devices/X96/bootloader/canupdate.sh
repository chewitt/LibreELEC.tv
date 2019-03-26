# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

# allow upgrades between arm and aarch64 images

if [ "$1" = "X96.aarch64" -o "$1" = "X96.arm" ]; then
  exit 0
else
  exit 1
fi
