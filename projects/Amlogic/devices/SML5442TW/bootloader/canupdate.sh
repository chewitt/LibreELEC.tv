#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

# allow upgrades between S905 and SML5442TW

if [ "$1" = "S905.arm" -o "$1" = "CZBOX.arm" ]; then
  exit 0
else
  exit 1
fi
