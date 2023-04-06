# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8189FS"
PKG_VERSION="63900adf1633d31d56af28ac4c535b618e7a5927"
PKG_SHA256="e3e25cb1ea0552498bd8473338339dceaf921440dc644a808ce61508bbc60a50"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/jwrdegoede/rtl8189ES_linux"
PKG_URL="https://github.com/jwrdegoede/rtl8189ES_linux/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Realtek RTL8189FS Linux driver"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       CONFIG_POWER_SAVING=n
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
}
