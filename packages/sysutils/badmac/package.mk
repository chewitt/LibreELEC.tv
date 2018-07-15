# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="badmac"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SECTION="system"
PKG_LONGDESC="badmac: systemd service for solving bad MAC address issues"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/badmac-config $INSTALL/usr/bin
}

post_install() {
  enable_service badmac-config.service
  enable_service badmac@eth0.service
}
