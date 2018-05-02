# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aml_autoscript"
PKG_VERSION="1.0"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain u-boot-tools-aml"
PKG_TOOLCHAIN="manual"

make_target() {
  for src in $PKG_DIR/scripts/*autoscript.src ; do
    $TOOLCHAIN/bin/mkimage -A $TARGET_KERNEL_ARCH -O linux -T script -C none -d "$src" "$(basename $src .src)" > /dev/null
  done

  cp -a $PKG_DIR/config/* $PKG_BUILD/
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader
    cp -a $PKG_BUILD/*autoscript $INSTALL/usr/share/bootloader/
}
