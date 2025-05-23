# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="firmware-imx"
PKG_VERSION="8.27-5af0ceb"
PKG_SHA256="61f925e606ab020b1a36f3f7f7e459c6847f5b9dbc79421f9ef86e8fc124eb2f"
PKG_ARCH="aarch64 arm"
PKG_LICENSE="other"
PKG_SITE="http://www.freescale.com"
PKG_URL="https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/${PKG_NAME}-${PKG_VERSION}.bin"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="firmware-imx: Freescale IMX firmware such as for the VPU"
PKG_TOOLCHAIN="manual"

unpack() {
  cd $(dirname ${PKG_BUILD})
  sh ${SOURCES}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.bin --auto-accept
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_firmware_dir)/imx/sdma
  mkdir -p ${INSTALL}/$(get_full_firmware_dir)/vpu

  case "${DEVICE}" in
    "iMX6")
      cp -P firmware/sdma/sdma-imx6q.bin ${INSTALL}/$(get_full_firmware_dir)/imx/sdma
      cp -P firmware/vpu/vpu_fw_imx6d.bin ${INSTALL}/$(get_full_firmware_dir)/vpu
      cp -P firmware/vpu/vpu_fw_imx6q.bin ${INSTALL}/$(get_full_firmware_dir)/vpu
      ;;
    "iMX8")
      cp -P firmware/sdma/sdma-imx7d.bin ${INSTALL}/$(get_full_firmware_dir)/imx/sdma
      cp -P firmware/vpu/vpu_fw_imx8_dec.bin ${INSTALL}/$(get_full_firmware_dir)/vpu
      ;;
  esac
}
