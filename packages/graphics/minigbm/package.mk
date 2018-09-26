# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="minigbm"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://chromium.googlesource.com/chromiumos/platform/minigbm"
PKG_VERSION="500928fd3a78322549d9602dac6a135a028ab0ae"
PKG_SHA256="c321058a8dad27902f210221988a3d5ad6070219b27e9b618a558f5fe9a5f284"
PKG_URL="https://github.com/chewitt/minigbm/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="minigbm-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain libdrm"
PKG_SECTION="graphics"
PKG_SHORTDESC="minigbm: A small library to support ARM mali blobs without GBM symbols"
PKG_AUTORECONF="no"
PKG_TOOLCHAIN="manual"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make ARCH=$TARGET_KERNEL_ARCH CROSS_COMPILE=$TARGET_KERNEL_PREFIX \
       CFLAGS=-DDRV_MESON=1 LIBDIR="$INSTALL/usr/lib"
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PR gbm.h $SYSROOT_PREFIX/usr/include/
    cp -PR gbm.pc $SYSROOT_PREFIX/usr/include/

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PR libminigbm.so.1.0.0 $SYSROOT_PREFIX/usr/lib
    ln -sf libminigbm.so.1.0.0 $SYSROOT_PREFIX/usr/lib/libgbm.so
    ln -sf libminigbm.so.1.0.0 $SYSROOT_PREFIX/usr/lib/libgbm.so.1

  mkdir -p $INSTALL/usr/lib
    cp -PR libminigbm.so.1.0.0 $INSTALL/usr/lib
    ln -sf libminigbm.so.1.0.0 $INSTALL/usr/lib/libgbm.so
    ln -sf libminigbm.so.1.0.0 $INSTALL/usr/lib/libgbm.so.1
}
