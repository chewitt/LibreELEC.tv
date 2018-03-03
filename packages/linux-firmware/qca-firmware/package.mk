################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
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
