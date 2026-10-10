# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="amlogic-boot-fip"
PKG_LICENSE="LicenseRef-nonfree"
PKG_VERSION="b3018ac4859669169de5c7edb0bd966fc480e534" # minix-u9h
PKG_SHA256="29087eb70e6dbb99331f0bf8282194b98a16ccbd38f4eb57b2f96174d9821243"
PKG_SITE="https://github.com/LibreELEC/amlogic-boot-fip"
PKG_URL="https://github.com/LibreELEC/amlogic-boot-fip/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Firmware Image Package (FIP) sources used to sign Amlogic u-boot binaries in LibreELEC images"
PKG_TOOLCHAIN="manual"
PKG_STAMP="${UBOOT_SYSTEM}"

post_unpack() {
  # rename dirs for alta/solitude
  mv ${PKG_BUILD}/aml-a311d-cc ${PKG_BUILD}/alta
  mv ${PKG_BUILD}/aml-s905d3-cc ${PKG_BUILD}/solitude
}
