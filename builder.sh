#!/bin/bash

SHELLSCRIPT="getCerts.sh"
ZIPFILE="self_certs.gz"
OUTFILE="selfExtract_by_dd.sh"

# 新增檔案自動編號
if [ -f "$OUTFILE" ];
then
  maxnum=0
  filename=$(echo $OUTFILE | awk -F. '{print $1}')
  fileext=$(echo $OUTFILE | awk -F. '{print $2}')
  for n in $(ls $OUTFILE_* | awk -F. '{print $1}' | grep -Po '\d+$');
  do
    if [[ $n -gt $maxnum ]];
    then
      maxnum=$n
    fi
  done
  OUTFILE=$filename\_$((maxnum+1)).$fileext
fi


if [ $1 ];
then 
  gzip -c $1 > $ZIPFILE;
  sed -e "s/9999/$(ls -al $SHELLSCRIPT | awk '{print $5}')/g" $SHELLSCRIPT >> $OUTFILE
else
  echo "請選擇一個原始檔"
  exit 1
fi

cat $ZIPFILE >> $OUTFILE 
rm $ZIPFILE
chmod u+x $OUTFILE
