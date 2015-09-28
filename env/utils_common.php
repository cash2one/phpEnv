<?php
/**
 * brief of Common.php:
 *
 * Common static functions
 *
 */

class Utils_Common
{
    //客户端解密参数 单次请求缓存
    public static $clientPuParams = array(
        'cuid' => null,
        'cua' => null,
        'cut' => null,
        'cen' => null,
    );

    /*
     * 递归检查数组内容合法性
     * 阿拉丁快速同步
     * @param retArr 待计算的数组
     * @return retArr
     */
    public static function checkAladdinArray($retArr) {
        if(($retArr === NULL) || (is_string($retArr) && $retArr === "") || (is_array($retArr) && empty($retArr))){
            return false;
        }elseif(is_array($retArr)){
            foreach ($retArr as $key => $val ) {
                if (!self::checkAladdinArray($val)) {
                    return false;
                }
            }
            return true;
        }else{
            return true;
        }
    }

    public static function inet_aton($ip){
        $a = ip2long($ip);
        $b = unpack("N",pack("L",$a));
        return $b[1];
    }

    // encode the sourceid
    public static function idEncode($num, $key = 2012) {
        $num = $num + $key;

        $jinzhi = 62;   //进制
        $str = "";
        while ( $num != 0 ) {
            $tmp = fmod ( $num, $jinzhi );
            if (($tmp >= 10) && ($tmp < 36)) {
                $str .= chr ( $tmp + 55 );
            } elseif (($tmp >= 36) && ($tmp < 62)) {
                $str .= chr ( $tmp + 61 );
            } else {
                $str .= $tmp;
            }
            $num = intval ( $num / $jinzhi );

        }
        return strrev ( $str );
    }

    // decode the sourceid
    public static function idDecode($str, $key = 2012) {
        $jinzhi = 62;   //进制
        $shu = 0;
        for($i = 0; $i <= strlen ( $str ) - 1; $i ++) {
            $tmp = substr ( $str, $i, 1 );
            if (ord ( $tmp ) <= 57) {
                $shu += $tmp * pow ( $jinzhi, strlen ( $str ) - $i - 1 );
            } elseif ((ord ( $tmp ) >= 65) && (ord ( $tmp ) <= 90)) {
                $shu += (ord ( $tmp ) - 55) * pow ( $jinzhi, strlen ( $str ) - $i - 1 );
            } else {
                $shu += (ord ( $tmp ) - 61) * pow ( $jinzhi, strlen ( $str ) - $i - 1 );
            }
        }
        return $shu - $key;
    }

    /**
     * 个人中心收藏判断
     */
    public static function userCenterCollect(&$resitem,$requestParams){
        //collect_di为同个人中心约定md5key
        $key = 'wise-tt@2012';
        $resitem['collect_di'] = substr(md5($resitem['resourceid'].$requestParams['word'].$key),0,16);
/*
        //个人中心股票
        if($requestParams['word'] == '上证指数' && $requestParams['word'] == '恒生指数' && $requestParams['word'] == '深证成指'){
            return 0;
        }
        */
        //当cookie存在合法BDUSS || 能取到ssid || 能取到phone 时展现收藏按钮
        if(isset($requestParams['ssid']) && $requestParams['ssid'] != 0){
            $resitem['is_collect'] = 1;
        }
        if(isset($_COOKIE['BDUSS']) && !empty($_COOKIE['BDUSS'])){
            if(strlen($_COOKIE['BDUSS'])>=20){
                $resitem['is_collect'] = 1;
            }
        }
        $phone = $_SERVER['HTTP_X_UP_CALLING_LINE_ID'];//x_up_calling_line_id
        if ( $phone!="")
        {
            $resitem['is_collect'] = 1;
        }
        //展现类型统计
        if($resitem['is_collect'] == 1){
            $rescfg = isset($resitem['resourceconfig'])? $resitem['resourceconfig']:array();
            $clog = isset($rescfg['clog'])? $rescfg['clog']:'unknown';
            $resitem['detailLog'] = $clog.'_collect';
        }
        //elseif 其他阿拉丁收藏展现量统计detailLog
    }

    /*
     * @description
     * 计算一个字符串的md5,折叠到整数之后返回
     *
     * @param str 待计算的字符串
     * @return  str的md5折叠到整数的值
     *
     */
    public static function hash2int( $str ){
        //计算128位的md5
        $md5sum = md5( $str, true );
        //将128位的md5折叠到4个32位的有符号长整数
        $a = unpack( 'l',substr($md5sum, 0, 4));
        $b = unpack( 'l',substr($md5sum, 4, 4));
        $c = unpack( 'l',substr($md5sum, 8, 4));
        $d = unpack( 'l',substr($md5sum, 12, 4));
        //把4个整数相加然后返回
        return current($a) + current($b) + current($c) + current($d) ;
    }

    /*
     * @description
     * 生成path模式使用的array
     *
     * @param array 所有get参数
     * @return  array path模式所需数组
     *
     */
    public static function getPathParamArray($allParams){
        $pathParams = Bd_Conf::getAppConf('path/params');
        if(empty($allParams) || empty($pathParams))
            return array();
        $arrRet = array();
        foreach($pathParams as $k => $v){
            if(isset($allParams[$k])){
                $arrRet[$k]['inPath'] = $v['inPath'];
                $arrRet[$k]['value'] = $allParams[$k];
            }elseif($v['value'] !== NULL){
                $arrRet[$k]['inPath'] = $v['inPath'];
                $arrRet[$k]['value'] = $v['value'];
            }
        }
        return $arrRet;
    }

    public static function getKeepParamArrayFromContext(){
        $arrParams = Saf_SmartMain::getCgi();
        return self::getPathParamArray($arrParams['query']);
    }

    /*
     * 跳转页
     */
    public static function showRedirectPage($errCode='default',$keepParams=array(),$errPageUrl){
        if(!isset($errPageUrl[$errCode]))
            $errCode='default';
        $pageUrl = $errPageUrl[$errCode];
        if(is_array($keepParams) && !empty($keepParams)){
            $pageUrl = Utils_IOProcess::urlKeepParam($pageUrl,$keepParams,false,false);
        }
        header('Location:' . $pageUrl);
        exit();
    }
    
    /*
     * 校验资源数据是否存在
     */
    public static function isSrcExist($arr){
        if( !(empty($arr) && $arr != "0" ) )
            return true;
        return false;
    }

    /*
     * 获得当前版式
     */
    public static function getCurAdapt(){
        $arrParams = Saf_SmartMain::getCgi();
        $adapt = $arrParams['page']['tpl'];
        switch($adapt){
            case 'middle':
                return 'colorful';
                break;
            case 'big':
                return 'touch';
                break;
            case 'utouch':
                return 'touch';
                break;
            default:
                return $adapt;
        }
    }

    /*
     * 解决xml2array的bug
     */
    public static function textToArray($arr){
        if(is_array($arr) && !empty($arr) && !isset($arr[0])){
            $tmp = $arr;
            $arr = array();
            $arr[0] = $tmp;
        }
        return $arr;
    }

    /*
     * byte2m g
     */
    public static function byteConvert($bytesNum=0){
        $bytesNum = (int)$bytesNum;
        if($bytesNum < 0 ) return false;

        $transNum = 1024;
        if($bytesNum < $transNum) return $bytesNum . 'B';
        if($bytesNum/$transNum < $transNum) return sprintf('%.0fK',$bytesNum/$transNum);
        if($bytesNum/($transNum*$transNum) < $transNum) return sprintf('%.2fM',$bytesNum/($transNum*$transNum));
        return sprintf('%.2fG',$bytesNum/($transNum*$transNum*$transNum));
    }

    /**
     * 获取电话号码
     */
    public static function dealPhone($phonestr){
        $phonestr = str_replace(array(' ','－'),array('','-'),$phonestr);
        preg_match( '/^([^\d]*)([\d-]+)(.*)$/i', $phonestr, $matches);
        if(!empty($matches[2])){
            $phone['num'] = str_replace('-','',$matches[2]);
            $phone['display'] = $matches[2];
        }
        if(!empty($matches[1])){
            $phone['title'] = $matches[1];
        }
        if(!empty($matches[3])){
            $phone['more'] = $matches[3];
        }
        return $phone;
    }

    public static function addParamToPu($pu,$puK,$puV){
        if($pu === '' || $puK === '' || $puV === '')
            return $pu;
        $pu_tmp = array();
        $pu_array = explode(',',$pu);
        foreach ($pu_array as $v){
            $tmpArr = explode('@',$v);
            $key = isset($tmpArr[0])?$tmpArr[0]:'';
            $value = isset($tmpArr[1])?$tmpArr[1]:'';
            if($value != ''){
                $pu_tmp[$key] = $value;
            }
        }

        $pu = '';
        $pu_tmp[$puK] = $puV;
        foreach($pu_tmp as $k => $v){
            $pu .= $k . '@' . $v . ',';
        }
        return rtrim($pu , ',');
    }

    /*
     * 百度客户端规范参数解析
     * @author: wutong03
     * @modifier: liukui 2013-04-15
     * @param pu 规范参数存在pu中
     * @param key 想要获取的参数
     * @param model 机型
     * @return retArr
     */
    public static function getValueFromPu($pu, $clientkey){
        if(empty($pu) || empty($clientkey)){
            return false;
        }
        $cache_value = self::getClientPuParams($clientkey);
        if($cache_value !== null){
            return $cache_value;
        }
        $pu = urldecode($pu);
        if(preg_match('/'.$clientkey.'@([^,]*)/', $pu, $mts)){
            $value = trim($mts[1]);
            if($clientkey !== 'cen'){
                $cen = self::getClientPuParams('cen');
                if(!isset($cen)){
                    $cen = self::getValueFromPu($pu, 'cen');//只调用一次
                    self::setClientPuParams('cen', $cen);
                }
                if($cen != false){//null&false
                    $enc_ks = explode('_', $cen);
                    if(in_array($clientkey, $enc_ks)){
                        $decoded_str = self::b64_decode($value);
                        self::setClientPuParams($clientkey, $decoded_str);
                        return $decoded_str;
                    }
                }
            }
            self::setClientPuParams($clientkey, $value);
            return $value;
        }else{
            return false;
        }
    }
    //获取缓存参数
    private static function getClientPuParams($ck){
        $clientPuParams = self::$clientPuParams;
        if(isset($clientPuParams[$ck])){
            return $clientPuParams[$ck];
        }else{//null或不在缓存列表里 返回null
            return null;
        }
    }
    //设置缓存参数
    private static function setClientPuParams($ck, $value){
        if(array_key_exists($ck, self::$clientPuParams) && $value !== null){//不可用isset
            self::$clientPuParams[$ck] = $value;
        }
        return;
    }

    /*
     * 百度客户端规范参数解析
     * @author: wutong03
     * @modified: liukui 2013-04-15
     * @param pu 规范参数存在pu中
     * @param key 想要获取的参数
     * @return retArr
     */
    public static function analyseClient($pu,$key){
        if(empty($pu) || empty($key)){
            return false;
        }
        //值对应正则匹配或explode后的顺序 不可随意更改
        $cuid_params = array('deviceid'=>1);
        $cua_params = array('device_width'=>1, 'device_hight'=>2, 'clientuatype'=>3,
                           'clientversion'=>4, 'device_ppi'=>5,);
        $cut_params = array('model'=>0, 'osversion'=>1, 'sdkversion'=>2,);
        $int_keys = array('device_width'=>1, 'device_hight'=>1, 'device_ppi'=>1, 'sdkversion'=>1);
        if(isset($cua_params[$key])){
            $pos = intval($cua_params[$key]);
            $cua = self::getValueFromPu($pu,'cua');
            $cua = $cua? $cua:self::getValueFromPu($pu,'ua');
            $cua_reg = '/(?:\w+_)?(\d+)_(\d+)_(\w+)_([\d\.]+)_(\w+)$/';
            if(preg_match($cua_reg, $cua, $mts)){
                $value = trim($mts[$pos]);
                if(isset($int_keys[$key])){
                    return intval($value);
                }
                return $value;
            }
            if(isset($int_keys[$key])){
                return 0;//默认值
            }
        }elseif(isset($cut_params[$key])){
            $pos = intval($cut_params[$key]);
            $cut = self::getValueFromPu($pu, 'cut');
            $cut = $cut? $cut:self::getValueFromPu($pu, 'ut');
            $cut_arr = explode('_', $cut);
            $value = isset($cut_arr[$pos])? $cut_arr[$pos]:false;
            if(isset($int_keys[$key])){
                return intval($value);
            }
            return $value;
        }elseif(isset($cuid_params[$key])){
            $pos = intval($cuid_params[$key]);
            $cuid = self::getValueFromPu($pu, 'cuid');
            if(preg_match('/^(?:BDS_)?([\w\-]+)(?:\|\w+)/', $cuid, $mts)){
                return $mts[$pos];
            }
        }
        return false;

    }

    /*
    *（1）自己拼URL方法：
    *bds://openurl?weburl=｛urldecode转码URL，用于map失效及统计｝&nativeurl=｛urldecode接口API URL｝
    *
    *｛urldecode接口API URL｝：
    * intent://product/[service/]action[?parameters]#Intent;scheme=bdapp;package=package;end
    *
    *｛urldecode接口API URL｝样例：
    *文档中 http://api.map.baidu.com/marker
    *替换成>>>
    *intent://map/{action?参数}#Intent;scheme=bdapp;package=com.baidu.BaiduMap;end
    *替换成>>>
    *intent://map/marker?q=银行&region=北京#Intent;scheme=bdapp;package=com.baidu.BaiduMap;end
    *
    *（2）调用公共函数替换url方法:
    *使用方法 $url = Utils_Common::transAppURL({action?参数});
    *存入模版比普通url多出‘_app’
    *
    */
    public static function transAppURL($interface){

        //if($product == 'map'){}

        //weburl即搜索结果页中过tc跳转的url，框会touch一下方便点击调权及统计，map出错后还可以做容错处理。
        //拼原tc跳转的相关参数
        $adapt = Utils_Common::getCurAdapt();

        //$weburl = urlencode($weburl);
        //nativeurl即上面解释中的API接口
        $nativeurl = "intent://map/$interface#Intent;scheme=bdapp;package=com.baidu.BaiduMap;end";
        $nativeurl = urlencode($nativeurl);
        return "bds://openurl?nativeurl=$nativeurl&weburl=";

        //if($product == 'vedio'){}

    }
    public static function siriAppUrlSwitch($matches,$aladdin){
        if($aladdin == 'sirimap'){
            $mapConf = Bd_Conf::getAppConf('device/sirimap');
            if( empty($matches[1]) || ($matches[1] == "0") ){
                return 0;
            }
            if($matches[1] >= $mapConf['mapv']){
                return $mapConf['switch'];
            }
            return 0;
        }
    }
    //框三期url替换开关逻辑
    public static function appUrlSwitch($pu,$applist,$aladdin,$aladetail){

        if($aladdin == 'map'){
            $mapConf = Bd_Conf::getAppConf('device/map');

            #最低框版本
            $clientversion = Utils_Common::analyseClient($pu,'clientversion');
            //如果小于最低版本 -1
            if(version_compare($clientversion,$mapConf['clientversion'],'<') == 1){
                return 0;
            }
            #屏蔽机型
            $model = Utils_Common::analyseClient($pu,'model');
            $mapConf['model'] = explode(",",$mapConf['model']);
            if(is_array($mapConf['model'])){
                foreach($mapConf['model'] as $modelk => $modelv){
                    if(strcasecmp(trim($modelv), trim($model)) == 0){
                        return 0;
                    }
                }
            }
            #最低机型版本
            $osversion = Utils_Common::analyseClient($pu,'osversion');
            if(version_compare($osversion,$mapConf['osversion'],'<') == 1){
                return 0;
            }
            #客户端名称
            $osname = self::getValueFromPu($pu,'osname');
            if($mapConf['osname'] != $osname){
                //return 0;
            }
            #高于最低地图版本返回1
            $mapVersion = empty($mapConf['mapv'][$aladetail])?$mapConf['mapv']['default']:$mapConf['mapv'][$aladetail];
            if(is_array($applist)){
                foreach($applist as $versionk => $versionv){
                    if(($versionv['package'] == $mapConf['mappackage']) && ($versionv['version'] >= $mapVersion)){
                        return $mapConf['switch'];
                    }
                }
            }
        }
        return 0;


        //if($product == 'vedio'){}
    }

    //屏幕物理宽度和首行分类个数分配
    private static function cntSimpleJ($osname, $uatype, $pu){
        $device_ppi = self::analyseClient($pu, 'device_ppi');
        $device_width = self::analyseClient($pu, 'device_width');
        if($uatype === 'android' && $device_ppi > 0){
            $device_wd = round($device_width * 160 / $device_ppi);
            if($osname !== 'baiduboxpad'){
                return ($device_wd >= 400)? 5:(($device_wd >= 360)? 4:3);
            }else{
                return ($device_wd >= 700)? 5:4;
            }
        }
        return 3;
    }

    //baiduboxapp垂搜分类
    public static function searchServiceUrl(&$baiduboxapp, $params){
        $pu = isset($params['pu'])? $params['pu']:null;
        $uatype = isset($params['uatype'])? $params['uatype']:null;
        $osname = isset($params['osname'])? $params['osname']:null;
        $sdkversion = self::analyseClient($pu, 'sdkversion');
        $baiduboxapp['cntbench'] = self::cntSimpleJ($osname, $uatype, $pu);
        $searchsrv = Bd_Conf::getAppConf('url/'.$osname.'Service/'.$uatype);
        if(empty($searchsrv)){//没有读取到配置
            $baiduboxapp['class_switch'] = false;
            return;
        }
        ksort($searchsrv);
        $kw = rawurlencode($params['word']);
        $searchservice = array();
        foreach($searchsrv as $rsitem){
            $iter_name = isset($rsitem['name'])? $rsitem['name']:'';
            $iter_url = isset($rsitem['url'])? $rsitem['url']:'None';
            if($iter_name === '视频' && strpos($iter_url, 'tt=%s') !== false){
                $nd = (intval($sdkversion) <= 7)? '16':'32';
                $iter_url = str_replace('tt=%s', 'tt='.$nd, $iter_url);
            }
            if($iter_url !== 'None'){
                $searchservice[$iter_name] = $iter_url.$kw;
            }
        }
        if($baiduboxapp['cntbench'] >= count($searchservice)){
            $baiduboxapp['cntbench'] = count($searchservice);
            $baiduboxapp['hasNavMore'] = false;
        }else{
            $baiduboxapp['hasNavMore'] = true;
        }
        $baiduboxapp['searchsvc'] = $searchservice;
    }
    /**
     * 通过useragent获取框版本号
     * @param  String $ua userAgent
     * @return String     version
     */
    public static function getBaiduboxVersionByUserAgent($ua){
        if(empty($ua)){
            return 0;
        }
        preg_match('/([\d+.]+)_(?:diordna|enohpi)_/', $ua, $matches);
        if(isset($matches[1])){
            return strrev($matches[1]);
        }else{
            preg_match('/baiduboxapp\/([\d+.]+)/', $ua, $matches);
            return isset($matches[1])?$matches[1]:0;
        }
        return 0;
    }

    //百度框参数收集
    public static function bdboxAppParser(&$baiduboxapp, $arrParams, $pu, $osname){
        $baiduboxapp['isbaiduboxapp'] = true;
        $uatype = self::analyseClient($pu, 'clientuatype');
        $uatype = $uatype ? $uatype : $arrParams['wiaui']['TA']['device_os'];

        $serverData = isset($arrParams['server'])? $arrParams['server']:array();
        $userAgent = isset($serverData['HTTP_USER_AGENT'])? $serverData['HTTP_USER_AGENT']:null;

        if($uatype == 'android'){//Bug fix:是否搜索词上框
            $baiduboxapp['setQuery'] = true;
        }elseif(strpos($userAgent, 'baiduboxapp') !== false && strpos($userAgent, '(Baidu; P1 ') !== false){
            $baiduboxapp['setQuery'] = true;
        }elseif(strpos($userAgent, 'baiduboxapp') !== false && strpos($userAgent, 'diordna') !== false){
            $baiduboxapp['setQuery'] = true;
        }

        if(strpos($userAgent,'iphone')!==false){
            //通过ua来判断是否是Android
            $baiduboxapp['isAndroid'] = 0;
        }else{
            $baiduboxapp['isAndroid'] = ($baiduboxapp['setQuery'] === true)? true:false;
        }


        $baiduboxapp['uatype'] = $uatype;
        //优先使用userAgent，userAgent有问题，再取pu公共参数
        $bd_version = self::getBaiduboxVersionByUserAgent($userAgent);
        $bd_version = ($bd_version&&$bd_version!=0) ? $bd_version : self::analyseClient($pu, 'clientversion');

        $baiduboxapp['bd_version'] = $bd_version;
        $bd_cuid = self::getValueFromPu($pu, 'cuid');
        $baiduboxapp['cuid'] = $bd_cuid;
        $searchwd = isset($arrParams['query']['word'])? $arrParams['query']['word']:'';
        $baiduboxapp['searchword'] = $searchwd;
        $class_switch = false;
        //垂搜分类切换支持与否
        if($uatype === 'android' && version_compare($bd_version, '4.0') >= 0){
            $class_switch = true;
        }elseif($uatype === 'iphone' && version_compare($bd_version, '3.4.0.0') >= 0){
            $class_switch = true;
        }elseif($osname == 'baiduboxpad' && $uatype == 'android'){
            $class_switch = true;
        }
        $baiduboxapp['class_switch'] = $class_switch;
        if($class_switch === true){
            $params['word'] = $searchwd;
            $params['pu'] = $pu;
            $params['osname'] = $osname;
            $params['uatype'] = $uatype;
            self::searchServiceUrl($baiduboxapp, $params);
        }
        return;
    }
    //baiduboxapp字符串b64解密
    public static function b64_decode($encoded_str){
        $decoded_str = null;
        try{
            $decoded_len = chpr_B64_Decode_php($encoded_str, 0);
            if($decoded_len > 0){
                $decoded_str = substr($encoded_str, 0, $decoded_len);
            }
        }catch(Exception $e){}
        return $decoded_str;
    }
    //遍历数据，递归修改编码
    public static function arr2utf8($arr){
        $ret=array();
                if(!is_array($arr)){
                        $ret = iconv('gbk','UTF-8//IGNORE',$arr);
                }else{
                        foreach($arr as $k =>$v){
                                if(is_array($v)){
                                        $ret[$k]=self::arr2utf8($v);
                                }else{
                                        $ret[$k]=iconv('gbk','UTF-8//IGNORE',$v);
                                }
                        }
                }
                return $ret;
    }
    /* 生成timg图片链接
     * timg文档http://wiki.babel.baidu.com/twiki/bin/view/Com/CloudOS/Timgonline
     * quality和size参数可能较为常用，单独提出来传递，其余参数通过kv形式通过$params数组传递
     */
    public static function timgUrl($src,$size="4",$quality=60,$params=array()){
        if(!is_string($src)){
            return;
        }
        $sec = time();
        $key = "wisetimgkey";
        $di = md5($key.$sec.$src);
        $scheme = "http://";
        $host   = "cdn01.baidu-img.cn";

        // 判断是否在https协议下
        $ishttps = Wise_Utils::isHttps();
        if($ishttps == 1){
            $strDictRst = Wise_Utils::getValueFromDict($host,'http_to_https');

            if(!empty($strDictRst)){
                $scheme = "https://";
                $host   = $strDictRst;
            }
        }
        
        $baseurl = $scheme.$host."/timg";
        $arrParams = Saf_SmartMain::getCgi();
        if (!empty($arrParams['sampling']) && !empty($arrParams['sampling']['sids'])) {
            $sids = $arrParams['sampling']['sids'];
            if ((stripos($sids,'12850') !== false) || (stripos($sids,'12851') !== false)) {
                $quality = 100;
            }
            if ((stripos($sids,'12850') !== false) && $_COOKIE['webp'] == "1") {
                $imgtype = 4;
            }
        }
        if ($imgtype) {
            $url = "$baseurl?wisealaddin&size=$size&imgtype=$imgtype&quality=$quality&sec=$sec&di=$di";
        } else {
            $url = "$baseurl?wisealaddin&size=$size&quality=$quality&sec=$sec&di=$di";
        }
        if(is_array($params)){
            foreach ($params as $key => $value) {
                $url .= "&$key=$value";
            }
        }
        $url .= "&src=".urlencode($src);
        return $url;
    }
    /*生成微站三期的跳转url*/
    public static function wzUrl($wzArr){
        if(empty($wzArr)){
            return null;
        }
        return $wzArr['url'];
        #if(empty($wzArr['sitetype'])
        #   || empty($wzArr['appid'])){
        #    return null;
        #}
        #$prefix="http://m.baidu.com/lightapp/".$wzArr['appid'];
        #if($wzArr['sitetype'] == "create"){
        #    return $prefix;
        #}elseif($wzArr['sitetype'] == "link"){
        #    if(!empty($wzArr["url"])){
        #        if(strpos($wzArr["url"],"http") === false){
        #            $wzArr["url"] = "http://". $wzArr["url"];
        #        }
        #        return $prefix."?page=".urlencode($wzArr["url"]);
        #    }
        #}else{
        #    return $prefix;
        #}
    }
    /*微站info信息的处理*/
    public static function wzInfo($wzinfo){
        if(empty($wzinfo)){
            return null;
        }
        $wzinfo = json_decode($wzinfo,true);
        if(!empty($wzinfo['settings'])){
            $wzinfo['settings'] = json_decode($wzinfo['settings'],true);
        }else{
            $wzinfo['settings'] = null;
        }
        return $wzinfo;
    }
    //获取微站信息
    public static function setxData($xdata=null,$isEncode=true,$xnum=0){
        $_tmp = array();
        if( empty($xdata)
            || !is_array($xdata) ){
            $_tmp[] = "{}";
            return $_tmp;
        }
        foreach($xdata as $key=>$value){
            if($isEncode){
                $_tmp[] = json_encode($value);
            }else{
                $_tmp[] = $value;
            }
        }
        if( !empty($xnum)
            && (count($xdata) > $xnum)){
            $_first = array_slice($_tmp,0,$xnum);
            $_tmp = array_merge($_first,$_tmp);
        }
        return $_tmp;
    }

    //获取在线提醒项目信息
    public static function getOnlineInfo($srcid = '', &$data) {
        $data['isonline'] = false;
        if(empty($srcid)){
                return;
        }
        $onlineConf = Bd_Conf::getAppConf('online');
        if(!empty($onlineConf) && !empty($onlineConf['srcid']) && !empty($onlineConf['appid'])){
            $appid = $onlineConf['srcid'][$srcid];
            if(!empty($appid) && !empty($onlineConf['appid'][$appid])){
                $appInfo = $onlineConf['appid'][$appid];
                $data['apikey'] = $appInfo['apikey'];
                $secretkey = $appInfo['secretkey'];
                $data['type'] = $appInfo['type'];
                $data['url'] = $appInfo['url']; 
                $data['ajaxurl'] = $appInfo['ajaxurl']; 
                $data['prixurl'] = $appInfo['prixurl']; 
                if(preg_match('/^(\w+\:\/\/[^\/ ]+)([^ ]*)/',trim($data['ajaxurl']),$matches)){
                    $data['ajaxurl'] = (Wise_Utils::getHttpsHost($matches[1])) . $matches[2];
                }
                if(!empty($data['apikey']) && !empty($secretkey)){

                    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
                    $password = '';
                    for($i = 0; $i < 10; $i++){
                        $password .= $chars[ mt_rand(0, strlen($chars) - 1) ];
                    }
                    $data['nonce'] = $password;
                    $data['csrftoken'] = md5($data['nonce'].$secretkey);
                            $data['isonline'] = true;
                }
            }
        }

    }
}
?>
