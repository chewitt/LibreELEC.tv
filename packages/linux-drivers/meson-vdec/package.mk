# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="meson-vdec"
PKG_VERSION="69466b817466f2bd607edadec7a6f215cd7e7bf9"
PKG_SHA256=""
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/jefflessard/meson-vdec"
PKG_URL="https://github.com/jefflessard/meson-vdec/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="An experimental meson-vdec driver"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 KBUILD_MODPOST_WARN=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       -C $(kernel_path) \
       M=${PKG_BUILD}/drivers/media/platform/amlogic/meson-vdec \
       CONFIG_VIDEO_MESON_VDEC=m

  # hack to avoid missing symbols with out-of-tree module
  make V=1 KBUILD_MODPOST_WARN=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       -C $(kernel_path) \
       M=$(kernel_path)/drivers/media/v4l2-core \
       CONFIG_V4L2_H264=m
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp drivers/media/platform/amlogic/meson-vdec/*.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp $(kernel_path)/drivers/media/v4l2-core/v4l2-h264.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
}
