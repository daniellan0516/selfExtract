#!/bin/bash
LINES=9999

# 抓憑證資料
filename='self_certs'
outfile='cert'
n=0
cert_start=false
url=''

if [ $1 ];
then
  if [[ "$1" =~ .*: ]];
  then
    url=$1
  else
    url=$1:443
  fi
  echo "網路連線模式($url)"
  openssl s_client -connect $url --showcerts 2>/dev/null < /dev/null 1> $filename
else
  echo "自解模式"
  tail --lines=$LINES $0 > $filename.gz
  gzip -d $filename.gz
fi

# 刪除舊資料
rm -rf $outfile-*

# 切割檔案
while read line; do

  # 找到開始標籤
  if [[ $line =~ ^-.*BEGIN ]];
    then
      n=$((n+1))
      cert_start=true
      echo $line >> $outfile-$n
      continue
  fi 

  # 招到結束標籤
  if [[ $line =~ ^-.*END ]];
    then
      cert_start=false
      echo $line >> $outfile-$n
  fi 

  # 寫入檔案
  if [ $cert_start == true ];
    then
      echo $line >> $outfile-$n
  fi

done < $filename

# openssl取時間
n=1
for f in $(ls $outfile-*)
do
  echo "第$n張憑證"
  cat $f | openssl x509 -noout -dates | awk -F= '{print $2}' | while read time;do echo $(date -d "$time" +'%Y-%m-%d %H:%M:%S'); done 
  n=$((n+1))
done

rm -rf $outfile-* $filename
exit 0
