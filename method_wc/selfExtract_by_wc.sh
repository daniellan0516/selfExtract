#!/bin/bash
LINES=15

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
�w�b certs ��W���ֆ���<�|�`��(��&��͈d��d����{vOЌ4-Y�W��U�>U�5Uei�e��|������O�}��B��wa�gOh�캟iu��n���%u����º�v�]�3��m�;m�����v����c��N����>�󖹣����P?�D����hְN���~X!E�̢i��	�
$�D�b����f*�/�c���]Q�=!C�L�`����P� �Y*U��M��$T��(P[��u�I���F4ey���w�J�,V����."�^(F7����tICUɅI��0�0`��i�p�6�Y��O1�]��;�#G�K�R���<�Rxjy�r A��M�2���b�:w�)�g�K��I�7&2��cƸP�-���1��C�Y�����>�b�v�t`�"�f��b���I"�[�i��;܋NP�A��7M���u))0Mt�
��R�n_�%�(��~�) L��g'�ݾߦ�4���N��%~�aCL�ώs�J&�v�4�����Q�ުC�µ	�E/f8�_G�Y�ɩP�C��;�6G��JӾ�.Ƥe��z�
���c�g��]���^����L/�S$�����_�/��P��m��i�2!����r,<G�x��}����-�^�\}�X�<��	>+%UO<*�>mS�#y҇�r�u�+ >�g�j�Ua��O�O�q��؅�_�5�6��9�)�j+;�����FbAbR��!&fؾ6�����	��\Z�_2DO���*ܛ2�  ���*�& �9���@Ƃ�u�^�.���_�C���Oj�2u�s_o@���=8�Su�'�H3�i�tɊu�(^�,����\B`�n��
L�/���Z�鎹�����_�}`��yx��!d2�v��ƥ:���U���,�2{��F��#�Z��+XZ��۲�S��0�N}_2��SX��ｦ&MnE�!�P��x�EƓB�� ��m��x8�"ɪ�ԊX��8�P�`O�{��B&�tXn�]���3�6���V�����:�� �֜$[1��Z͙\�7�\\D<������^�gK,�%�7��c"�Ue%d���kqW��Ę��5�1댮�FP�
_G/�渃D�0�*=���h�@�!��}���(Fh �����>�J\O�[�}��b��\ځ������c�K���P-��,���eF�/�X�|  ��n!�mi�<2�1̨�l�W��e�CWi����:�q��_~�Ve�,#;��[�N����u������+󷶝�k�
��ѲU��%uN��MuQ�n��O%��I��+�)4��9:U<㛪��D���{����;+��ڐB	����vO\O���k`�0v}k���˧���fm�f�>�9ſ��7�@_ܱ�-O߼�>�aUJ`8FY����}�� %	{�VA���׻��,������Bv)ɜ=W(�8���q�{�#ӵ��D�X|�=��2��{!/��H���������J�W��,7\];*��8z�mT4D�wC�<Ǝ����u"ݢ�b�C҃��{v�� �6u�j��%y�_�e�-� ���q���,�:;A����T/�3�{ݎCCJ$ %Z��̬��̺����W�,����NO�X��ϋ�#	�m4�&K��A��$C}�Y�0y��+�9e����;P#?c�|��C�M���S�p��7A��R��p�4N�o�o�,��J��JX��C�_�a���OjH����Ѷ����_y��Wz8JD+>Y_B�gj����#!Vh&��Wh�MY_��=��E���%�	�[�	�z�q����3�ȧ��e�or�ݖM�G7�0g��-���H�e�{H��I����＀��!yXMC���'Q��;�����+\�C�`�
{��?�K����%�K�0���c��.���c�,F$<U��m���.�_��7�f�d{�BI�42̲�^�SҎ��qĹg����Ue�^�0���t(4���A��_�B2��Z��[.�T(�qH�ƴʈ����I�?�=�Ts}�2d��6��b׺��E���B�@�,�7M��h~�s��^6%XV�Y�ҴD�о>���:t������q���#���7���B]*WŔ��&lK
��-t��� �X�רj���-P���C������ґwW5���?���\/h�	�ի�
��:������Ip~��X	�S�+D���1<[��2)��l^�L��si����.�Ѣ����^�ks���RD���+���T'����W��"�jz#i���~��G"��N�ߗ8cI�vy2#:�[2��P�,2�UL���IAt��m&����Dr���D�kD����s4_��@ۧyVWXYSu%R^�0���
0<61���V\��T���QTQ��hxXix;���-/y��:�j	���2$hq7f���i�JLM��]�:��>�VyYO���d?��� ��~���ָ��4��{�?u�f�7�G}|��G�o�H�F��NztF�@���Ѿf	.���bT�����:N��G��:�ض+����d�e��Z��MX����]��v�ft��������N��5^�c	Q�3�Yo� �R�o�Aa�Ec~�M����y����<� ��<�q����wi�O��~B|B�w9�H�3���X:��y�āF.pɜp��#p�.d2����t����O�@���)O�b�EK���Z�Q�xr%y�����Ʉ����*�vO+��d�O���rO�&>aYE*�oL��2��jY�&7`�����L;�N<����j�I��@��n,�|	Y;�V�����ځxz�9�. _NUp�<�i�����%dw����z'���p�W>�������<W���GmֶA�ʏ�՗dIHlN��6CdGƱ�����K�e��U-z%9Y�6ը�v�-��g�#ɻ>�$�Փ��Y��4ޗ`�z�� ;}���m��Y-�nN/#ՙt)$���}v��mn/R�N'K��5�PZY;{ۑ
t��ZTȩ!��L�x1�S����2�r�$F�3�c�Gٚ�5�^�GҞ�SC�g&�:�Ɗ�+Ѿ��|Ǐl������ST�q܂���k4R�'�ym�3�%�',�ʘ~�NQ�@������o�λOMP�\z�gl�,�<�_o.�x!7��|�J���0R�V�����H�?�@��D�Q*9-��T1�Ky������X�;�������qDY�m��P�g�D�S�U�KW�Fݚt�ɨX�<e�:_s����TX���2�{O*�Y�R�q�]-���4W*�BSۂ3l�&H�����?�gFW'������D�����Թ����3ą�[�7E!
#|ǱV��I<��i���c��:��M���3l��X��'�w�6��m��_]n2��,.-[�䶑�q�8uz�8���ADyT&'$�x���m~�������F�>�"�1�x_�� �O�\�K�_;_�/�$�{�J�ԺT -�����_�(J<⮫�'�
��ֱ�#:&n<�ky�Aj�D�ǆ���p��ٯ���`Z�L�^��g]���#U��%��
8�a��l$Ӕڿ����qt�z��n}<'�,��Dē�I;+��=��z�%8�cEH)H�s����&�su�Q����B��K��/Y�t�w����%?nw�kr��<�_��ʺn��_��=�ǐj��,~�_G}�x��ְ�J�k�9�m̐=�]�%q���3/ ;�~����ƻ~i�w,͘�{4V\5;)^~�9����aG|d}��)�R�u�_��S�kc?�0��~�a+�Mm���s��ا�����Y��y�I����w�l����-�I7��m��毛ǿ����<N�{�A���"^�u�:o����?��v��S5k�ʛ�����i�)�ᅪ�,�΍���}�0����{7[#�o�e��������}$�#�eK����.��-���?u�����+2��W  
