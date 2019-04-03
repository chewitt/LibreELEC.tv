#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

image="EMMC-backup.img.gz"

OUTDIR=$1

if [ "$OUTDIR" = "" ]
then
    OUTDIR="/storage/backup/ddbr"
else
    if [ ! -d "$OUTDIR" ] ; then
        echo " PROGRAM EXITED DUE TO ERROR: NO DIR $OUTDIR !!!"
        exit 1
    fi
fi

emmc=$2

if [ "$emmc" = "" ]
then
    emmc="/dev/mmcblk1"
else
    if [ ! -e "$emmc" ] ; then
	echo "Not found EMMC !!!!"
	exit 1
    fi
fi

if [ ! -f "$OUTDIR/$image" ] ; then
    echo "Not found file backup $OUTDIR/$image"
    exit 1
fi

gunzip -c $OUTDIR/$image | dd of=$emmc

echo "Done! restore backup completed."
poweroff
exit 0
