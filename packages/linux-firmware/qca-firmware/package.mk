# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="qca-firmware"
PKG_VERSION="50f9e1a"
PKG_SHA256="18333079e07abdea85400f14dac15a11f2683106dd768e6ae6ec0008d34e7eda"
PKG_ARCH="arm aarch64"
PKG_LICENSE="BSD-3c"
PKG_SITE="http://linode.boundarydevices.com/repos/apt/ubuntu-relx/pool/main/q/qca-firmware/"
PKG_URL="https://github.com/chewitt/qca-firmware/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="linux-firmware"
PKG_SHORTDESC="qca9377 bluetooth firmware"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_firmware_dir)/qca
    cp -a qca/tfbtfw11.tlv $INSTALL/$(get_full_firmware_dir)/qca
}
