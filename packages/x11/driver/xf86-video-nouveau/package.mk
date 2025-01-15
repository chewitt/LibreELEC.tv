# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xf86-video-nouveau"
PKG_VERSION="8bf766606f1502fa481f1103ff704cc9dd13c337"
PKG_SHA256="c0b37ee0445b8d746a821b0850cfba49ddead596f6d282c58994daca76c2c85b"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="https://nouveau.freedesktop.org/"
PKG_URL="https://gitlab.freedesktop.org/xorg/driver/${PKG_NAME}/-/archive/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libXcomposite libXxf86vm libXdamage libdrm util-macros systemd xorg-server"
PKG_LONGDESC="Open-source Xorg graphics driver for Nvidia graphics."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--with-xorg-module-dir=${XORG_PATH_MODULES}"
