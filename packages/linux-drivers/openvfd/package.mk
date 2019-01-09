# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018 Arthur Liberman (arthur_liberman (at) hotmail.com)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="openvfd"
PKG_VERSION="d5af7690fc5148f6103964b950d1dc237ef08513"
PKG_SHA256="3a09c8a61d3a106b8038433788c6c948abb9f4a2198e2934527984f72db395bc"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/arthur-liberman/linux_openvfd"
PKG_URL="https://github.com/arthur-liberman/linux_openvfd/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux openvfd-conf"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="Linux OpenVFD is an open source Linux driver for VFD displays"
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
}

post_install() {
  enable_service openvfd-config.service
  enable_service openvfd.service
}
