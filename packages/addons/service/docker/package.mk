# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="docker"
PKG_REV="3"
PKG_ARCH="any"
PKG_LICENSE="ASL"
PKG_SITE="http://www.docker.com/"
PKG_DEPENDS_TARGET="cli containerd ctop docker-compose moby runc tini"
PKG_SECTION="service/system"
PKG_SHORTDESC="Docker is an open-source engine that automates the deployment of any application as a lightweight, portable, self-sufficient container that will run virtually anywhere."
PKG_LONGDESC="Docker containers can encapsulate any payload, and will run consistently on and between virtually any server. The same container that a developer builds and tests on a laptop will run at scale, in production*, on VMs, bare-metal servers, OpenStack clusters, public instances, or combinations of the above."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Docker"
PKG_ADDON_TYPE="xbmc.service"

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

    # cli
    cp -P $(get_build_dir cli)/bin/docker ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

    # moby
    cp -P $(get_build_dir moby)/bin/dockerd ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp -P $(get_build_dir moby)/bin/docker-proxy ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/docker-proxy

    # containerd
    cp -P $(get_build_dir containerd)/bin/containerd ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/containerd
    cp -P $(get_build_dir containerd)/bin/containerd-shim-runc-v2 ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/containerd-shim-runc-v2

    # ctop
    cp -P $(get_build_dir ctop)/bin/ctop ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/ctop

    # runc
    cp -P $(get_build_dir runc)/bin/runc ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/runc

    # tini
    cp -P $(get_build_dir tini)/.${TARGET_NAME}/tini-static ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/docker-init
}

post_install_addon() {
  sed -e "s/@DISTRO_PKG_SETTINGS_ID@/${DISTRO_PKG_SETTINGS_ID}/g" -i "${INSTALL}/default.py"
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/etc
    # docker.conf
    cp -P ${PKG_DIR}/config/docker.conf ${INSTALL}/etc

  mkdir -p ${INSTALL}/usr/bin
    # dockermon.py
    cp -P ${PKG_DIR}/lib/dockermon.py ${INSTALL}/usr/bin/dockermon

    # cli
    cp -P $(get_build_dir cli)/bin/docker ${INSTALL}/usr/bin

    # moby
    cp -P $(get_build_dir moby)/bin/dockerd ${INSTALL}/usr/bin
    cp -P $(get_build_dir moby)/bin/docker-proxy ${INSTALL}/usr/bin/docker-proxy

    # containerd
    cp -P $(get_build_dir containerd)/bin/containerd ${INSTALL}/usr/bin/containerd
    cp -P $(get_build_dir containerd)/bin/containerd-shim-runc-v2 ${INSTALL}/usr/bin/containerd-shim-runc-v2

    # ctop
    cp -P $(get_build_dir ctop)/bin/ctop ${INSTALL}/usr/bin/ctop

    # docker-compose
    cp -P $(get_build_dir docker-compose)/docker-compose ${INSTALL}/usr/bin/docker-compose

    # runc
    cp -P $(get_build_dir runc)/bin/runc ${INSTALL}/usr/bin/runc

    # tini
    cp -P $(get_build_dir tini)/.${TARGET_NAME}/tini-static ${INSTALL}/usr/bin/docker-init
}

post_install() {
  enable_service docker.service
}
