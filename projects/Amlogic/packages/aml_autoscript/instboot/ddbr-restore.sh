#!/bin/sh

image="EMMC-backup.img.gz"

OUTDIR=$1

emmc=$2

echo "Start FULL restore eMMC to eMMC"

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

gunzip -c $OUTDIR/$image.gz | dd of=/dev/$emmc

echo "Done"

exit 0
