# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="inputstream.airplay"
PKG_VERSION="1bb7a1a94fa584d3d9e32cfcca062ad84f77dc8d"
PKG_SHA256="815a56109e72d4f091e56a272947df8c576b40b2122220efe7b397c76a7aed58"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/popcornmix/inputstream.airplay"
PKG_URL="https://github.com/popcornmix/inputstream.airplay/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libplist openssl uxplay ${MEDIACENTER}:host"
PKG_DEPENDS_UNPACK="uxplay"
PKG_SECTION=""
PKG_SHORTDESC="AirPlay Receiver"
PKG_LONGDESC="Receives AirPlay screen mirroring, video streamed from apps, and audio from iOS and macOS, and plays them through Kodi."

PKG_IS_ADDON="yes"
PKG_TOOLCHAIN="cmake"

pre_configure_target() {
  # force -march=native off to allow cross-compiled builds
  PKG_CMAKE_OPTS_TARGET+=" -DNO_MARCH_NATIVE=ON \
                           -DUXPLAY_SOURCE_DIR=${BUILD}/build/uxplay-$(get_pkg_version uxplay)"
}

addon() {
  install_binary_addon "${PKG_ADDON_ID}"

  cp -Rp "${PKG_INSTALL}/usr/lib/kodi/addons/${PKG_ADDON_ID}/bin" "${ADDON_BUILD}/${PKG_ADDON_ID}/"
}
