# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

# allow upgrades between aarch64 and arm images

if [ "$1" = "AMLGX.aarch64" -o "$1" = "AMLGX.arm"  ]; then
  exit 0
else
  exit 1
fi
