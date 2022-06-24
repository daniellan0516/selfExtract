#!/bin/bash

SHELLSCRIPT=getCerts.sh
ZIPFILE="self_cert.gz"
OUTFILE="selfExtract.sh"

rm -rf $OUTFILE
sed -e "s/9999/$(ls -al $SHELLSCRIPT | awk '{print $5}')/g" $SHELLSCRIPT >> $OUTFILE

cat $ZIPFILE >> $OUTFILE 
chmod u+x $OUTFILE
