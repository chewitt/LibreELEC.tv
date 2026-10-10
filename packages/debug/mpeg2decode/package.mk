# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mpeg2decode"
PKG_VERSION="13818-5-2005"
PKG_SHA256="ba372c4069e9c96d0675e1442dbcb5a9c7f46d8ca760866bd51f185641ba759e"
PKG_LICENSE="OSS"
PKG_SITE="https://standards.iso.org/ittf/PubliclyAvailableStandards/"
PKG_URL="https://standards.iso.org/ittf/PubliclyAvailableStandards/c039486_ISO_IEC_13818-5_2005_Reference_Software.zip"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ISO/IEC 13818-5 MPEG-2 video reference decoder, used by fluster for conformance testing."
PKG_TOOLCHAIN="manual"

unpack() {
  mkdir -p ${PKG_BUILD}
  unzip -q -o ${SOURCES}/${PKG_NAME}/${PKG_SOURCE_NAME} video.zip -d ${PKG_BUILD}
  unzip -q -o ${PKG_BUILD}/video.zip -d ${PKG_BUILD}
  rm -f ${PKG_BUILD}/video.zip
}

make_target() {
  make -C video/decoder CC="${CC}" \
    CFLAGS="${CFLAGS} -std=gnu89 -Wno-implicit-function-declaration -Wno-implicit-int -DVERIFY -DTRACE -DVERBOSE" \
    LIBRARYDIR="${LDFLAGS}" LIBS="" mpeg2decode
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp video/decoder/mpeg2decode ${INSTALL}/usr/bin
}
