# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tm16xx"
PKG_VERSION="f3bbd1cd22a44cca9a67f2fd6b6aa8346b5f68ef"
PKG_SHA256="920419d6b61298c3220aff211846dfaa41548807f60642bfe50009e8de5b7c03"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/jefflessard/tm16xx-display/"
PKG_URL="https://github.com/jefflessard/tm16xx-display/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Linux kernel driver utilities for TM16XX compatible controllers"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"

pre_make_target() {
  sed -i '/Description=*./a\ConditionPathIsDirectory=/sys/class/leds/display' display.service
  sed -i '/ExecStartPre/d' display.service
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/sbin
    cp display-service ${INSTALL}/usr/sbin
  mkdir -p ${INSTALL}/usr/lib/systemd/system
    cp display.service ${INSTALL}/usr/lib/systemd/system
}

post_install() {
  enable_service display.service
}
