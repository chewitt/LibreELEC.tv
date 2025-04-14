# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nouveau-firmware"
PKG_VERSION="1.0"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/envytools/firmware/"
PKG_LONGDESC="nouveau-firmware: nVidia firmware download and extraction for nouveau"
PKG_DEPENDS_TARGET="toolchain Python3"
PKG_TOOLCHAIN="manual"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin/nouveau
    cp ${PKG_DIR}/scripts/NVIDIA-Linux-x86_64-340.108.sha256 ${INSTALL}/usr/bin/nouveau
    cp ${PKG_DIR}/scripts/nouveau-firmware-setup ${INSTALL}/usr/bin/nouveau
    cp ${PKG_DIR}/scripts/nouveau-firmware.py ${INSTALL}/usr/bin/nouveau
    python_compile ${INSTALL}/usr/bin/nouveau
}

post_install() {
  enable_service nouveau-firmware.service
}
