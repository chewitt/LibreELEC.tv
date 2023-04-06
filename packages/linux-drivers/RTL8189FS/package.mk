# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8189FS"
PKG_VERSION="3f34f380715b88e4a3ef049b3a60e2fc69ccc9bd"
PKG_SHA256="40a0890d3ea2d6d2b58748a9e05e20a14942c0f7652a0178e7466e8279106345"
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
