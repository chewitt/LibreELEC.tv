# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="drm-info"
PKG_VERSION="v2.10.0"
PKG_SHA256="a9b5ec9d4bada16afe6d4d3b405dffe851a10481f9423ef91a4de501afdc713d"
PKG_LICENSE="MIT"
PKG_SITE="https://gitlab.freedesktop.org/emersion/drm_info"
PKG_URL="https://gitlab.freedesktop.org/emersion/drm_info/-/archive/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="libdrm json-c"
PKG_LONGDESC="Small utility to dump info about DRM devices"
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET="-Dman-pages=disabled \
                       -Dlibpci=disabled"
