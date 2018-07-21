# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

# allow upgrades between older KVIM and S905 community builds

if [ "$1" = "KVIM.aarch64" ] || [ "$1" = "KVIM.arm" || "$1" = "S905.arm" ]; then
  exit 0
else
  exit 1
fi
