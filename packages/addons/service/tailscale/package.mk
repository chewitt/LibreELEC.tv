# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tailscale"
PKG_VERSION="1.78.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/tailscale/tailscale"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="service"
PKG_SHORTDESC="tailscale: makes creating software-defined networks easy"
PKG_LONGDESC="Tailscale (${PKG_VERSION}) makes creating software-defined networks easy: securely connecting users, services, and devices."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Tailscale"
PKG_ADDON_TYPE="xbmc.service"

PKG_SOURCE_NAME="tailscale-${PKG_VERSION}-${ARCH}.tgz"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="8eb0ae11ac2f80beac379722b37651e6ef328d098fec0425ca2786c1c8f087e3"
    PKG_URL="https://pkgs.tailscale.com/stable/tailscale_${PKG_VERSION}_arm64.tgz"
    ;;
  "arm")
    PKG_SHA256="6e96650f9073f80c2ef4b1c4bd6a717db8211bb0828a02aea1d60d9d88b8d005"
    PKG_URL="https://pkgs.tailscale.com/stable/tailscale_${PKG_VERSION}_arm.tgz"
    ;;
  "x86_64")
    PKG_SHA256="3db491bd6800012173cb6b739fa6705272f71da3e622f23639a3a385f2474a89"
    PKG_URL="https://pkgs.tailscale.com/stable/tailscale_${PKG_VERSION}_amd64.tgz"
    ;;
esac

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp ${PKG_BUILD}/tailscale ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp ${PKG_BUILD}/tailscaled ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    #cp ${PKG_DIR}/source/bin/tailscaled-setup ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
}
