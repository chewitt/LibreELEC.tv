
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

# allow upgrades from S905 generic builds

if [ "$1" = "LaFrite.aarch64" ] || [ "$1" = "LaFrite.arm" ]; then
  exit 0
else
  exit 1
fi
