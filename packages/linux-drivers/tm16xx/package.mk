# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tm16xx"
PKG_VERSION="a93b257ed4c73780fcdefbb1f1dd189599cf6ecc" # main HEAD
PKG_SHA256="0c663387fb02dacb3f8b528779e16814543f25ae1d7fd3577d53b27b01f7e535"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/jefflessard/tm16xx-display/"
PKG_URL="https://github.com/jefflessard/tm16xx-display/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Linux kernel driver for auxiliary displays using TM1628 compatible controllers"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  kernel_make V=1 KDIR=$(kernel_path) module
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
  mkdir -p ${INSTALL}/usr/sbin
    cp display-service ${INSTALL}/usr/sbin
    cp display-utils ${INSTALL}/usr/sbin
  mkdir -p ${INSTALL}/usr/lib/systemd/system
    cp display.service ${INSTALL}/usr/lib/systemd/system
}

post_install() {
  enable_service display.service
}
