# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ssv6051"
PKG_VERSION="5ebfff4a8b411bf85eb9bec2003eb27e2948d464"
PKG_SHA256=""
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/chewitt/ssv6051"
PKG_URL="https://github.com/chewitt/ssv6051/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="ssv6051-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_LONGDESC="iComm / South Silicon Valley SSV6051 driver for LibreELEC"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  if [ "$TARGET_KERNEL_ARCH" = "arm64" ]; then
    PLATFORM="s905-linux"
  else
    PLATFORM="s805-linux"
  fi

  cd $PKG_BUILD
    ./ver_info.pl include/ssv_version.h
    cp Makefile.libreelec Makefile
    sed -i 's/@@PLATFORM@@/'"$PLATFORM"'/g' Makefile
    make module SSV_ARCH="$TARGET_KERNEL_ARCH" \
                SSV_CROSS="$TARGET_KERNEL_PREFIX" \
                SSV_KERNEL_PATH="$(kernel_path)"
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    find $PKG_BUILD/ -name \*.ko -not -path '*/\.*' -exec cp {} $INSTALL/$(get_full_module_dir)/$PKG_NAME \;

  mkdir -p $INSTALL/$(get_full_firmware_dir)/ssv6051
    cp $PKG_BUILD/firmware/* $INSTALL/$(get_full_firmware_dir)/ssv6051
}
