# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL88X2BU"
PKG_VERSION="549257e6f62e8d7931e15f963aa06bb3c622ec7e"
PKG_SHA256="4219a049b669ab2a9310ea551e5ce74805454ac4db6fed28df1dafa2e09a953d"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/cilynx/rtl88x2bu"
PKG_URL="https://github.com/cilynx/rtl88x2bu/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Realtek RTL88x2BU Linux driver"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make modules \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       CONFIG_POWER_SAVING=n
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
}
