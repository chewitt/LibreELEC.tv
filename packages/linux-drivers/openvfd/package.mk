# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018 Arthur Liberman (arthur_liberman (at) hotmail.com)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="openvfd"
PKG_VERSION="6897fc44fe8b8fe02c599c8fa9b2ff3c3f288ac3"
PKG_SHA256="5e544c05a0ec343bd33cc7d4ab8b443933159204fda47dd6016fc54b77f616a0"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/arthur-liberman/linux_openvfd"
PKG_URL="https://github.com/chewitt/linux_openvfd/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="linux_openvfd-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_LONGDESC="openvfd: An open source Linux driver for VFD displays"
PKG_TOOLCHAIN="manual"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make ARCH=$TARGET_KERNEL_ARCH \
       CROSS_COMPILE=$TARGET_KERNEL_PREFIX \
       -C "$(kernel_path)" M="$PKG_BUILD/driver"
  make OpenVFDService
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    find $PKG_BUILD/ -name \*.ko -not -path '*/\.*' -exec cp {} $INSTALL/$(get_full_module_dir)/$PKG_NAME \;

  mkdir -p $INSTALL/usr/bin
    cp -P $PKG_DIR/scripts/openvfd-config $INSTALL/usr/bin
    cp -P $PKG_DIR/scripts/openvfd $INSTALL/usr/bin

  mkdir -p $INSTALL/usr/sbin
    cp -P OpenVFDService $INSTALL/usr/sbin

  mkdir -p $INSTALL/usr/config/openvfd
    cp -P $PKG_BUILD/conf/* $INSTALL/usr/config/openvfd
}

post_install() {
  enable_service openvfd-config.service
  enable_service openvfd.service
}
