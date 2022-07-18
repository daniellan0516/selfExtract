#!/bin/bash

SHELLSCRIPT="getCerts_by_wc.sh"
ZIPFILE="zip"
OUTFILE="selfExtract_by_wc.sh"

rm -rf $OUTFILE

if [ $1 ];
then 
  gzip -c $1 > $ZIPFILE
  sed -e "s/9999/$(wc -l $ZIPFILE | awk '{print $1}')/g" $SHELLSCRIPT >> $OUTFILE
else
  echo "請選擇一個原始檔案"
  exit 1
fi

cat $ZIPFILE >> $OUTFILE
#rm $ZIPFILE
chmod u+x $OUTFILE
