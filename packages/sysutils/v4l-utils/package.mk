# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="v4l-utils"
PKG_VERSION="1.14.1"
PKG_SHA256="7974e5626447407d8a1ed531da0461c0fe00e599a696cb548a240d17d3519005"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://linuxtv.org/"
PKG_URL="http://linuxtv.org/downloads/v4l-utils/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="system"
PKG_SHORTDESC="v4l-utils: Linux V4L2 and DVB API utilities and v4l libraries (libv4l)."
PKG_LONGDESC="Linux V4L2 and DVB API utilities and v4l libraries (libv4l)."

PKG_CONFIGURE_OPTS_TARGET="--without-jpeg \
	--enable-static \
	--disable-shared"

pre_configure_target() {
  # cec-ctl fails to build in subdirs
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME
}

make_target() {
  make -C utils/keytable CFLAGS="$TARGET_CFLAGS"
  make -C utils/ir-ctl CFLAGS="$TARGET_CFLAGS"
  if [ "$CEC_FRAMEWORK_SUPPORT" = "yes" ]; then
    make -C utils/cec-ctl CFLAGS="$TARGET_CFLAGS"
  fi
  make -C lib CFLAGS="$TARGET_CFLAGS"
  make -C utils/dvb CFLAGS="$TARGET_CFLAGS"
  make -C utils/v4l2-ctl CFLAGS="$TARGET_CFLAGS"
}

makeinstall_target() {
  make install DESTDIR=$INSTALL PREFIX=/usr -C utils/keytable
  make install DESTDIR=$INSTALL PREFIX=/usr -C utils/ir-ctl
  if [ "$CEC_FRAMEWORK_SUPPORT" = "yes" ]; then
    make install DESTDIR=$INSTALL PREFIX=/usr -C utils/cec-ctl
  fi
  make install DESTDIR=$INSTALL PREFIX=/usr -C utils/dvb
  make install DESTDIR=$INSTALL PREFIX=/usr -C utils/v4l2-ctl
}

create_multimap() {
  local f name protocols
  name="$1"
  protocols="$2"
  shift 2
  (
    echo "# table $name, type: $protocols"
    for f in "$@" ; do
      echo "# $f"
      grep -v "^#" $INSTALL/usr/lib/udev/rc_keymaps/$f
    done
  ) > $INSTALL/usr/lib/udev/rc_keymaps/$name
}

post_makeinstall_target() {
  local default_multi_maps f keymap

  rm -rf $INSTALL/etc/rc_keymaps
    ln -sf /storage/.config/rc_keymaps $INSTALL/etc/rc_keymaps

  mkdir -p $INSTALL/usr/config
    cp -PR $PKG_DIR/config/* $INSTALL/usr/config

  rm -rf $INSTALL/usr/lib/udev/rules.d
    mkdir -p $INSTALL/usr/lib/udev/rules.d
    cp -PR $PKG_DIR/udev.d/*.rules $INSTALL/usr/lib/udev/rules.d

  # install additional keymaps without overwriting upstream maps
  (
    set -C
    for f in $PKG_DIR/keymaps/* ; do
      if [ -e $f ] ; then
        keymap=$(basename $f)
        cat $f > $INSTALL/usr/lib/udev/rc_keymaps/$keymap
      fi
    done
  )

  # array of local package keymaps to include in the default multimap
  default_map="cubox_i hp_mce rc6_mce xbox_one xbox_360 zotac_ad10"

  # create multimap_default
  create_multimap multimap_default "RC6 NEC" $default_map

  # create multimap_custom
  if [ -n "$MULTIMAP_CUSTOM" ]; then
    create_multimap multimap_custom "RC6 NEC" $multimap_default $MULTIMAP_CUSTOM
  else
    create_multimap multimap_custom "RC6 NEC" $multimap_default \
      odroid wetek_hub wetek_play_2 minix_neo
  fi

  # use multi-keymap instead of default one
  sed -i '/^\*\s*rc-rc6-mce\s*rc6_mce/d' $INSTALL/etc/rc_maps.cfg
  cat << EOF >> $INSTALL/etc/rc_maps.cfg
#
# Custom LibreELEC configuration starts here
#
# multimap for MCE receivers
# *		rc-rc6-mce	rc6_mce
*		rc-rc6-mce	multimap_default
# multimap for amlogic devices
meson-ir	*		multimap_custom
EOF
}
