#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

#BACKUP_DATE=$(date +%Y%m%d%H%M%S)
#image="$(date +%Y%m%d%H%M%S)-EMMC-backup.img"
image="EMMC-backup.img"

OUTDIR=$1

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

if [ "$OUTDIR" = "" ]
then
    OUTDIR="/storage/backup/ddbr"
    [ ! -d $OUTDIR ] && mkdir -p $OUTDIR
else
    if [ ! -d "$OUTDIR" ] ; then
        echo " PROGRAM EXITED DUE TO ERROR: NO DIR $OUTDIR !!!"
        exit 1
    fi
fi

dd if=$emmc | gzip > $OUTDIR/$image.gz

echo "Done! Full backup completed."
poweroff
exit 0
