# 自解檔範例
## 準備
* [ShellScirpt](getCerts.sh) * 1
  為了避免執行完ShellScirpt後，執行到壓縮檔(出現錯誤訊息)，務必在ShellScirpt最後寫上exit
* [壓縮檔](self_cert.gz) * 1
  不限定格式，可視需求替換成其他類型檔案

## [自解檔製作器](builder.sh)
運用sed做替換dd的skips大小
```bash
#!/bin/bash

SHELLSCRIPT="getCerts.sh"
ZIPFILE="self_cert.gz"
OUTFILE="selfExtract.sh"

rm -rf $OUTFILE
sed -e "s/9999/$(ls -al $SHELLSCRIPT | awk '{print $5}')/g" $SHELLSCRIPT >> $OUTFILE

cat $ZIPFILE >> $OUTFILE 
chmod u+x $OUTFILE
```

