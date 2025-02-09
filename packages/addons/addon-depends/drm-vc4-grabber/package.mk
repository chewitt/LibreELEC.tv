# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="drm-vc4-grabber"
PKG_VERSION="a0ed242818109d4d7f8bba4830878ce647b6c878"
PKG_SHA256="f5db271b1ddc3dad40477168c1404bbeb4c29e585aaac785926e49462147c596"
PKG_LICENSE="UNKNOWN"
PKG_SITE="https://github.com/rudihorn/drm-vc4-grabber"
PKG_URL="https://github.com/rudihorn/drm-vc4-grabber/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain cargo:host"
PKG_LONGDESC="Raspberry Pi DRM-VC4 grabber for Hyperion"
PKG_TOOLCHAIN="manual"

make_target() {
  export RUSTC_LINKER=${CC}
  cd src
  cargo build \
    --target ${TARGET_NAME} \
    --release
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -P drm-vc4-grabber ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/usr/lib/systemd/system
    cp -P systemd/drm-capture.service ${INSTALL}/usr/lib/systemd/system/drm-capture.service
    sed -i 's|^ExecStart*$|ExecStart=/usr/bin/drm-vc4-grabber|g' ${INSTALL}/usr/lib/systemd/system/drm-capture.service

}

post_install() {
  enable_service drm-capture.service
}
