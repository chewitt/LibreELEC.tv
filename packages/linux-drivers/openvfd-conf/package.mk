# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="openvfd-conf"
PKG_VERSION="cb789ccb50436d1c9ac43630700d6962d3da4522"
PKG_SHA256="96e2b61a9096821d47f180b671c6cfec3f28d3f7bb2ba9edd5501031648f98c4"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/arthur-liberman/vfd-configurations"
#PKG_URL="https://github.com/arthur-liberman/vfd-configurations/archive/$PKG_VERSION.tar.gz"
PKG_URL="https://github.com/chewitt/vfd-configurations/archive/$PKG_VERSION.tar.gz" # temp
PKG_SECTION="driver"
PKG_LONGDESC="Configuration files for the Linux OpenVFD driver"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/config/openvfd
    cp -P $PKG_BUILD/* $INSTALL/usr/config/openvfd
}
