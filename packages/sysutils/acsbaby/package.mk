# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024 Team LibreELEC (https://libreelec.tv)

PKG_NAME="acsbaby"
PKG_VERSION="489f94df3aa2dd303300dd82b5700d3679d67b42"
PKG_SHA256="6f19fcb14195d765d30f7a785b1e3370d037f79cb724a78b47d5b217b0880fef"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://git.vitali64.duckdns.org/utils/acsbaby.git"
PKG_URL="https://git.vitali64.duckdns.org/utils/acsbaby.git/snapshot/acsbaby-${PKG_VERSION}.tar.gz"
PKG_LONGDESC="ACSBaby is a tool for generating acs.bin data"
PKG_TOOLCHAIN="make"

#pre_make_target() {
#  unset LDFLAGS
#}

#make_target() {
#  make V=1 \
#       CFLAGS=${CFLAGS} \
#       CC=${TARGET_KERNEL_PREFIX}
#}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp ${PKG_BUILD}/acsbaby ${INSTALL}/usr/bin
}
