# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8812AU"
PKG_VERSION="8742be693a8a47b0bdfca3cc015f98627952fc30"
PKG_SHA256="271d7d5f8370c026453d5708e94f41900b0a3a50cc586b3c9bfc281994160d9f"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lwfinger/rtw88"
PKG_URL="https://github.com/lwfinger/rtw88/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Realtek RTL8812AU Linux driver using upstream test sources!"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/rtw88
    cp *.ko ${INSTALL}/$(get_full_module_dir)/rtw88

  mkdir -p ${INSTALL}/$(get_full_firmware_dir)/rtw88
    cp firmware/*.bin ${INSTALL}/$(get_full_firmware_dir)/rtw88
}
