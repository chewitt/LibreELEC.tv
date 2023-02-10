# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8189ES"
PKG_VERSION="a0ea38760274f643570792e15cff52807c548ee3"
PKG_SHA256="37700221694d58d3ae5232261e466e4de40fcf5298908b1cf31142c134b43932"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/jwrdegoede/rtl8189ES_linux"
PKG_URL="https://github.com/jwrdegoede/rtl8189ES_linux/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Realtek RTL8189ES and RTL8189ETV Linux driver"
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
