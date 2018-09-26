# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

# allow upgrades between aarch64 and S905 generic builds

if [ "$1" = "WeTek_Play_2.aarch64" -o "$1" = "S905.arm" ]; then
  exit 0
else
  exit 1
fi
