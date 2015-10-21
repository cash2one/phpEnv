#!/bin/sh
tplname=short_video
to=/Volumes/linuxsir



fe_php_parentpath=~/aladdin-wise/library/search/searchaladdin
fe_tpl_parentpath=~/aladdin-wise/searchaladdin

work_php_parentpath=odp/app/search/library/search/searchaladdin
work_tpl_parentpath=odp/template/search/searchaladdin



#第一个参数，指定发往地址,默认是我的测试剂
if [[ $# == 1 ]];then
	to=$1
fi


echo "=>work  success"
echo "to  ${to}/${work_tpl_parentpath}/$tplname"
echo "to  ${to}/${work_php_parentpath}"
cp iphone.tpl ${to}/${work_tpl_parentpath}/$tplname/
tplname=${tplname//_/''}
#scp ${fe_php_parentpath}/${tplname}SrcPreProcessor.php ${to}:${work_php_parentpath}/




