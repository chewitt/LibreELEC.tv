# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="brcmfmac_sdio-firmware"
PKG_VERSION="dbdbe5317bcf93e0fe6a128bf921e53bead3801e"
PKG_SHA256="01495bd565d6adff0ed21f800993e1a5a0ccddbc1751f18ba222c2f4abf9be4e"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/LibreELEC/brcmfmac_sdio-firmware"
PKG_URL="https://github.com/LibreELEC/brcmfmac_sdio-firmware/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Broadcom SDIO firmware used with LibreELEC"
PKG_TOOLCHAIN="manual"

post_makeinstall_target() {
  FW_TARGET_DIR=${INSTALL}/$(get_full_firmware_dir)

  if find_file_path firmwares/${PKG_NAME}.dat; then
    FW_LISTS="${FOUND_PATH}"
  else
    FW_LISTS="${PKG_DIR}/firmwares/any.dat ${PKG_DIR}/firmwares/${TARGET_ARCH}.dat"
  fi

  for fwlist in ${FW_LISTS}; do
    [ -f ${fwlist} ] || continue
    while read -r fwline; do
      [ -z "${fwline}" ] && continue
      [[ ${fwline} =~ ^#.* ]] && continue
      [[ ${fwline} =~ ^[[:space:]] ]] && continue

      for fwfile in $(cd ${PKG_BUILD} && eval "find ${fwline}"); do
        [ -d ${PKG_BUILD}/${fwfile} ] && continue
        if [ -f ${PKG_BUILD}/${fwfile} ]; then
          mkdir -p $(dirname ${FW_TARGET_DIR}/brcm/${fwfile})
            cp -Lv ${PKG_BUILD}/${fwfile} ${FW_TARGET_DIR}/brcm/${fwfile}
        else
          echo "ERROR: Firmware file ${fwfile} does not exist - aborting"
          exit 1
        fi
      done
    done < ${fwlist}
  done

  mkdir -p ${INSTALL}/usr/bin
    cp ${PKG_DIR}/scripts/brcmfmac-firmware-setup ${INSTALL}/usr/bin
}

post_install() {
  enable_service brcmfmac-firmware.service
}
