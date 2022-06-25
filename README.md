# 自解檔範例
## 準備
* [ShellScirpt](getCerts.sh) * 1
  為了避免執行完ShellScirpt後，執行到壓縮檔(出現錯誤訊息)，務必在ShellScirpt最後寫上exit
* [原始檔](certs) * 1
  任意類型的檔案(為了配合LINUX作業，所以這邊準備憑證的資料)
## 使用方法
```bash
  ./builder.sh certs
```

## [自解檔製作器](builder.sh)
運用sed做替換dd的skips大小
```bash
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
```
