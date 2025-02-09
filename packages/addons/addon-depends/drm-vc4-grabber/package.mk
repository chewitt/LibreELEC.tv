# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="drm-vc4-grabber"
PKG_VERSION="6229d5e8323c5c6ec96823dce598bc4b8bb36a0e"
PKG_SHA256="1fc761b3f6b38c5313449cde1e959d6a164161ec06935b54a68ede88411af866"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/rudihorn/drm-vc4-grabber"
PKG_URL="https://github.com/rudihorn/drm-vc4-grabber/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain cargo:host"
PKG_LONGDESC="Raspberry Pi DRM Grabber for Hyperion"
PKG_TOOLCHAIN="manual"

make_target() {
  export RUSTC_LINKER=${CC}
  cd src
  cargo build \
    --target ${TARGET_NAME} \
    --release

  ${STRIP} ${PKG_BUILD}/.${TARGET_NAME}/target/${TARGET_NAME}/release/drm-vc4-grabber
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -P ${PKG_BUILD}/.${TARGET_NAME}/target/${TARGET_NAME}/release/drm-vc4-grabber ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/usr/lib/systemd/system
    sed -i 's|^ExecStart=.*$|ExecStart=/usr/bin/drm-vc4-grabber|g' ${PKG_BUILD}/systemd/drm-capture.service
    cp -P ${PKG_BUILD}/systemd/drm-capture.service ${INSTALL}/usr/lib/systemd/system/drm-capture.service
}

post_install() {
  enable_service drm-capture.service
}
