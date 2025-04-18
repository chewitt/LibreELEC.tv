# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lcdd"
PKG_VERSION="71877ee059a238400b5f6b41cee7c43a3df00334"
PKG_SHA256="e910c7d748b58cc57543dc8845f8b2bcd0592dddd58bd72a55a58e90e6bfd861"
PKG_VERSION_DATE="0.5dev+2024-12-14"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://lcdproc.org/"
PKG_URL="https://github.com/lcdproc/lcdproc/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain freetype libftdi1 libgpiod libhid libugpio libusb ncurses serdisplib"
PKG_SECTION="service"
PKG_SHORTDESC="LCDproc: Software to display system information from your Linux/*BSD box on a LCD"
PKG_LONGDESC="LCDproc (${PKG_VERSION}) is a piece of software that displays real-time system information from your Linux/*BSD box on a LCD. The server supports several serial devices: Matrix Orbital, Crystal Fontz, Bayrad, LB216, LCDM001 (kernelconcepts.de), Wirz-SLI, Cwlinux(.com) and PIC-an-LCD; and some devices connected to the LPT port: HD44780, STV5730, T6963, SED1520 and SED1330. Various clients are available that display things like CPU load, system load, memory usage, uptime, and a lot more."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-parallel -cfg-libs"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="LCDproc"
PKG_ADDON_TYPE="xbmc.service"

PKG_CONFIGURE_OPTS_TARGET="--enable-drivers=all \
                           --enable-freetype \
                           --enable-libhid \
                           --enable-libftdi \
                           --disable-libpng \
                           --enable-libusb \
                           --disable-libX11"

pre_configure_target() {
  CFLAGS+=" -O3"
}

addon() {
  drivers="none|$(cat ${PKG_BUILD}/.${TARGET_NAME}/config.log | sed -n "s|^DRIVERS=' \(.*\)'|\1|p" | sed "s|.so||g" | tr ' ' '|')"

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/config

  cp -PR ${PKG_DIR}/resources ${ADDON_BUILD}/${PKG_ADDON_ID}

  cp -PR ${PKG_INSTALL}/etc/LCDd.conf ${ADDON_BUILD}/${PKG_ADDON_ID}/config/
  cp -PR ${PKG_INSTALL}/usr/lib       ${ADDON_BUILD}/${PKG_ADDON_ID}/lib/
  patchelf --add-rpath '${ORIGIN}/../../lib.private' ${ADDON_BUILD}/${PKG_ADDON_ID}/lib/lcdproc/glcd.so
  cp -PR ${PKG_INSTALL}/usr/sbin      ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private
  cp -L $(get_install_dir serdisplib)/usr/lib/libserdisp.so.2 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private

  sed -e "s|^DriverPath=.*$|DriverPath=/storage/.kodi/addons/service.lcdd/lib/lcdproc/|" \
      -e "s|^#Foreground=.*$|Foreground=no|" \
      -e "s|^#ServerScreen=.*$|ServerScreen=blank|" \
      -e "s|^#Backlight=.*$|Backlight=open|" \
      -e "s|^#Heartbeat=.*$|Heartbeat=open|" \
      -e "s|^#TitleSpeed=.*$|TitleSpeed=4|" \
      -e "s|^#Hello=\"  Welcome to\"|Hello=\"Welcome to\"|" \
      -e "s|^#Hello=\"   LCDproc!\"|Hello=\"${DISTRONAME}\"|" \
      -e "s|^#GoodBye=\"Thanks for using\"|GoodBye=\"Thanks for using\"|" \
      -e "s|^#GoodBye=\"   LCDproc!\"|GoodBye=\"${DISTRONAME}\"|" \
      -e "s|^#normal_font=.*$|normal_font=/usr/share/fonts/liberation/LiberationMono-Bold.ttf|" \
      -i ${ADDON_BUILD}/${PKG_ADDON_ID}/config/LCDd.conf

  sed -e "s/@DRIVERS@/${drivers}/" \
      -i ${ADDON_BUILD}/${PKG_ADDON_ID}/resources/settings.xml

}
