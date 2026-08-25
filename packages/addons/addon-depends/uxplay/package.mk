# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="uxplay"
PKG_VERSION="462153392f2e30937424922039ff9f0cda5e7b1a"
PKG_SHA256="0f5bf6f2ab3d1ac3ccaf4418afe00137ec1ba97c2a345710202fca40f6a1fb85"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/FDH2/UxPlay"
PKG_URL="https://github.com/FDH2/UxPlay/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Airplay Unix mirroring server"
PKG_TOOLCHAIN="manual"

# source only: inputstream.airplay uses the lib folder
