################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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

PKG_NAME="amlogic-boot-fip"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE=""
PKG_SECTION="tools"
PKG_SHORTDESC="Amlogic Boot Firmware"
PKG_LONGDESC="Amlogic Boot Firmare files used to wrap U-Boot to provide a functional boot blob"
PKG_TOOLCHAIN="manual"

case "$DEVICE" in
  P212)
    PKG_VERSION="20170606"
    PKG_SHA256="957c96037bcd792a4139cc33eded2f006d55a82c0c56ae69ef43bdcb76a255e2"
    PKG_URL="https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/p212_fip_${PKG_VERSION}.tar.gz"
    PKG_SOURCE_DIR="fip"
    ;;
  LePotato)
    PKG_VERSION="20170606"
    PKG_SHA256="957c96037bcd792a4139cc33eded2f006d55a82c0c56ae69ef43bdcb76a255e2"
    PKG_URL="https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/libretech-cc_fip_${PKG_VERSION}.tar.gz"
    PKG_SOURCE_DIR="fip"
    ;;
  Khadas_VIM*)
    PKG_VERSION="20180207"
    PKG_SHA256="8dfdf0a267bbedde2229f22d41f0573f67a182a2bb4852db3baae884315f5acc"
    PKG_URL="https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/khadas-vim_fip_${PKG_VERSION}.tar.gz"
    PKG_SOURCE_DIR="fip"
    ;;
  NanoPi_K2)
    PKG_VERSION="20170412"
    PKG_SHA256="4b5778098ca2a4f7ade06db7752ec9f77775d67e438d6fba0c669a4959ff7200"
    PKG_URL="https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/nanopi-k2_fip_${PKG_VERSION}.tar.gz"
    PKG_SOURCE_DIR="fip"
    ;;
  Odroid_C2)
    PKG_VERSION="s905_6.0.1_v3.7"
    PKG_SHA256="3ee700fd3a6439997060ac6d21217b0adba3a801876707fae70988f8ce6c3fef"
    PKG_URL="https://github.com/hardkernel/u-boot/archive/${PKG_VERSION}.tar.gz"
    PKG_SOURCE_DIR="u-boot-${PKG_VERSION}"
    ;;
esac
