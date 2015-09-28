<?php
/**
 * 一些基本的公共函数集合
 *
 */
class Wise_Utils
{
    /*
    *    结果页头部导航，首页预取部分和结果页头部部分同时使用
    */
    public function getRedirectLinks ($requestParams,$ref) {
        $kw = urlencode($requestParams['word']);
        $ab_anchor_list = array(
            "linknews" => "http://m.baidu.com/news?fr=searchresult01",
            "linkxs" => "http://m.baidu.com/s?tn=bdx&st=105141&word=".$kw,
            "linkzhidao" => "http://wapiknow.baidu.com/index/?st=3&ref=".$ref."&word=".$kw,
            "linktieba" => "http://tieba.baidu.com/f?mo_device=1&vit=www_nav&kw=".$kw,
            "linkimg" => "http://image.baidu.com/i?tn=wiseala&iswiseala=1&ie=utf8&wiseps=1&word=".$kw,
            "linkhi" => "http://i.hi.baidu.com/?ref=".$ref,
            "linkmap" => "http://map.baidu.com/?newmap=1&ie=utf-8&itj=45&s=s%26wd%3D".$kw,
            "linkmap2" => "http://map.baidu.com/mobile/mobile.html?itj=45",
            "linkhao123" => "http://m.hao123.com/?itj=49",
            "linkzb" => "http://itunes.apple.com/app/baidu-mobile/id382201985?mt=8",
            "linksb" => "http://waps.baidu.com/s?itj=426",
            "linkbaike" => "http://wapbaike.baidu.com/search?st=3&ref=".$ref."&word=".$kw,
            "linkmp3" => "http://music.baidu.com/s?f=ms&itn=baidump3mobile&rf=mobile&ct=671088640&lf=&rn=20&lm=0&gate=33&ie=utf-8&ref=".$ref."&key=".$kw,
            "linkvideo" => "http://m.video.baidu.com?ie=utf-8&ref=".$ref."&wtj=ws",
            "linksb2" => "http://waps.baidu.com/?itj=424",
            "linkwk" => "http://wk.baidu.com/search?ref=".$ref."&word=".$kw,
            "linkindex" => "http://m.baidu.com/?icolor=3",
        );
        $vvparams = "&ssid=".$requestParams['ssid']."&from=".$requestParams['from']."&bd_page_type=".$requestParams['bd_page_type']."&uid=".$requestParams['uid']."&pu=".$requestParams['pu'];
        $retList = array();
        foreach ($ab_anchor_list as $k => $v) {
            $vv = $v.$vvparams;
            if ($k == "linkvideo") {
               $vv = $vv."#search=".$kw;
            } elseif ($k == "linknews") {
                $vv = $vv."#search/".$kw;
            }
            $retList[$k] = htmlspecialchars($vv);
        }
        /*图搜url替换、去掉公共参数部分 2014-12-03*/
        $retList['linkimg'] = htmlspecialchars($ab_anchor_list['linkimg']);
        return $retList;
    }

    /*
     * 给url增加一个参数
     */
    function addUrlParam ($url,$key='',$value='',$transfer=true,$all=0)
    {
        if($key ==''){return $url;}
        $url = str_replace('&amp;', '&', $url);
        $urlInfo = @parse_url($url);
        if($all==1){
            $url = $urlInfo['scheme'].'://'.$urlInfo['host'].(empty($urlInfo['port'])?'':':'.$urlInfo['port']).$urlInfo['path'];
        }else {
            $url = $urlInfo['path'];
        }
        if ($urlInfo['query']) {
            $url .= '?';
            $queryList = array();
            parse_str($urlInfo['query'], $queryList);
            $queryList[$key]=$value;
            foreach ($queryList as $key => $value) {
                if($value !== '')
                    $url .= ($key . '=' . urlencode($value) . '&');
            }
            $url = rtrim($url, '&');
        }
        else {
            if($value !== '')
                $url .= '?' . $key . '=' . urlencode($value);
        }
        if($transfer !== true){
            return $url;
        }else{
            return str_replace('&', '&amp;', $url);
        }
    }    


    public static function wordEmTruncate($str, $length = 0, $encoding = 'UTF-8', $endMark = '..', $rawStartLabel = '\2', $rawEndLabel = '\3', $outStartLabel = '<em>', $outEndLabel = '</em>',$outputEncoding='utf-8'){
        //排除结束符 需要截断的长度
//        $length = $length - strlen($endMark);
        if($str === '' || $length < 0){
            return '';
        }

        //add by tianxing for fix bug
        if(strtolower($encoding) == 'gbk') {

            $encoding = 'gb18030';
        }

        if(strtolower($outputEncoding) == 'gbk') {

            $outputEncoding = 'gb18030';
        }

        if(strtolower($encoding) == 'utf8') {
            
            $encoding = 'UTF-8';
        }
        
        if(strtolower($outputEncoding) == 'utf8') {
            
            $outputEncoding = 'UTF-8';
        }
        //删除不可见字符\x01-\x1f
        $invalidStr = array('\1'=>"\x01",'\2'=>"\x02",'\3'=>"\x03",'\4'=>"\x04",'\5'=>"\x05",'\6'=>"\x06",'\7'=>"\x07",'\10'=>"\x08",'\11'=>"\x09",'\12'=>"\x0a",'\13'=>"\x0b",'\14'=>"\x0c",'\15'=>"\x0d",'\16'=>"\x0e",'\17'=>"\x0f",'\20'=>"\x10",'\21'=>"\x11",'\22'=>"\x12",'\23'=>"\x13",'\24'=>"\x14",'\25'=>"\x15",'\26'=>"\x16",'\27'=>"\x17",'\30'=>"\x18",'\31'=>"\x19",'\32'=>"\x1a",'\33'=>"\x1b",'\34'=>"\x1c",'\35'=>"\x1d",'\36'=>"\x1e",'\37'=>"\x1f",);
        if(isset($invalidStr[$rawStartLabel]))
            unset($invalidStr[$rawStartLabel]);
        if(isset($invalidStr[$rawEndLabel]))
            unset($invalidStr[$rawEndLabel]);
        //$str = preg_replace("/[".implode("", $invalidStr)."]/",'',$str);
        $str = str_replace($invalidStr,'',$str);
        if(is_string($str)){
            if(isset($_ENV['HHVM']))
            {
                $str = Wise_Utils::hhvm_htmlspecialchars_decode($str);
            }
            else
            {
                $str = htmlspecialchars_decode($str);
            }
        }
        $arrStr = array();
        //进入tag模式
        if($rawStartLabel == 'TAG'){//<aa23aa></aa23aa>
            if($rawEndLabel == '') return $str;
            $arrTags = explode('-',$rawEndLabel);//支持用-分割多个tag名
            $tagTmp = array();
            foreach($arrTags as $tagV){
                $tagTmp[] = '</'.$tagV.'>';
                $tagTmp[] = '<'.$tagV.'(?:\s+[^>]*?)?>';
            }
            $regex = implode('|',$tagTmp);
            $regex = '(?:'.$regex.')';
            if(is_string($str)){
                $arrStr = preg_split("!$regex!",$str,-1);
            }    
        }else{//普通模式
            if(is_string($str)){
                $arrStr = preg_split("/[${rawStartLabel}${rawEndLabel}]/",$str,-1);
            }
        }
        $returnStr = $subStr = '';
        $subLen = 0;
        //0长度未满足截断要求；
        //1长度已经满足截断要求，且刚好是输入字符串的最后一个字符；
        //2长度已经满足截断要求，但输入字符串后面还有内容
        $isOver = 0;
        $splitCount = count($arrStr);
        if($arrStr[$splitCount-1] == '')
        {
            $splitCount--;
        }
        if($length == 0){
            for ($i=0;$i<$splitCount;$i++){
                $subStr = $arrStr[$i];
                if($i%2 === 0){
                    $returnStr .= htmlspecialchars($subStr);
                }else{
                    $returnStr .= $outStartLabel . htmlspecialchars($subStr) . $outEndLabel;
                }
            }
        }
        else
        {
            $length = $length - strlen($endMark);
            for ($i=0;$i<$splitCount;$i++){
                $result = Wise_Utils::wordTruncate($arrStr[$i],$length,$encoding);
                if(is_array($result)){
                    $subStr = $result[0];
                    $subLen = $result[1];
                    $isOver = $result[2];
                }else{  
                    continue;
                }
                if($i%2 === 0)
                {   
                    $returnStr .= $subStr; 
                }
                else
                {
                    if($isOver == 1)
                    {
                        $result = Wise_Utils::wordTruncate($arrStr[$i], 0, $encoding);
                        $subStr = $result[0];
                        $subLen = $result[1];
                        $isOver = $result[2];    
                    }
                    $returnStr .= $outStartLabel.$subStr.$outEndLabel;
                }
                $length = $length - $subLen;    
                if($isOver > 0 ){
                    break;//结束
                }else{
                    if($length <= 0) break;
                }
            }
        }

        if($encoding != $outputEncoding){
            $returnStr = iconv($encoding, $outputEncoding, $returnStr);
        }
        if( $i<($splitCount-1) || ($i==($splitCount-1) && $isOver==1) ){
            return $returnStr . $endMark;
        }else { 
            return $returnStr;
        }   
    }
    
    public static function wordTruncate($str, $length = 0, $encoding = 'UTF-8')
    {
        if ($str === '' || $length < 0) {
            return '';
        }

        if(strtolower($encoding) == 'gbk') {

            $encoding = 'gb18030';
        }
        
        $isTruncate = true;
        if($length == 0)
        {
            $isTruncate = false;
        }

        if(strtolower($encoding) == 'utf8') {

            $encoding = 'UTF-8';
        }

        if(strtolower($encoding) != 'utf-8') {

            $str = iconv($encoding, 'UTF-8', $str);
        }
        
        //输入字符的个数
        $mbLen = mb_strlen($str, 'UTF-8');
        //匹配出每一个字符
        $subLen = 0;  //已经读取的字符长度
        $chrLen = 0;  //读取的字符长度
        $isOver = 0;  //是否超过要求字符长度
        $subStr = ''; //输出的字符串
        for ($i = 0; $i < $mbLen; $i++) {
            //寻找起始位置
            $mbChr = mb_substr($str, $i, 1, 'UTF-8');
            if (1 == strlen($mbChr)) {
                //英文字符
                $chrLen = 1;//0.5
                $isValid = 1;
                if ($mbChr == '&') 
                {
                    $special_chars = mb_substr($str, $i+1, $mbLen-$i-1, 'UTF-8');
                    if($mb_pos = mb_strpos($special_chars, ';', 0, 'UTF-8'))
                    {
                        if(Wise_Utils::htmlDereference(mb_substr($str, $i+1, $mb_pos, 'UTF-8')))
                        {
                            $subStr .= '&'.mb_substr($str, $i+1, $mb_pos, 'UTF-8').';';
                            $i += $mb_pos+1;
                            $isValid = 0;
                        }
                    }
                }
                if($isValid == 1)
                {
                    $subStr .= htmlspecialchars($mbChr);
                }
            } else {
                //其他字符
                $chrLen = 2;//
                $subStr .= $mbChr;
            }
            $subLen += $chrLen;
            
            if ($subLen >= $length && $isTruncate) {
                if($i < ($mbLen - 1)){
                    //判断是否溢出 $i==$mbLen时也算取完了 不算溢出
                    $isOver = 1;
                }
                break;
            }
        }

        if(strtolower($encoding) != 'utf-8') {

            $subStr = iconv('UTF-8', $encoding, $subStr);
        }
        
        return array($subStr,$subLen,$isOver);
    }
    
    public static function htmlDereference($str)
    {
        if( !is_string($str))
        {
            return false;
        }
        $special_chars = "|AElig|Aacute|Acirc|Agrave|Alpha|Aring|Atilde|Auml|Beta|Ccedil|Chi|Dagger|Delta|ETH|Eacute|Ecirc|Egrave|Epsilon|Eta|Euml|Gamma|Iacute|Icirc|Igrave|Iota|Iuml|Kappa|Lambda|Mu|Ntilde|Nu|OElig|Oacute|Ocirc|Ograve|Omega|Omicron|Oslash|Otilde|Ouml|Phi|Pi|Prime|Psi|Rho|Scaron|Sigma|THORN|Tau|Theta|Uacute|Ucirc|Ugrave|Upsilon|Uuml|Xi|Yacute|Yuml|Zeta|aacute|acirc|acute|aelig|agrave|alefsym|alpha|amp|and|ang|aring|asymp|atilde|auml|bdquo|beta|brvbar|bull|cap|ccedil|cedil|cent|chi|circ|clubs|cong|copy|crarr|cup|curren|dArr|dagger|darr|deg|delta|diams|divide|eacute|ecirc|egrave|empty|emsp|ensp|epsilon|equiv|eta|eth|euml|euro|exist|fnof|forall|frac12|frac14|frac34|frasl|gamma|ge|gt|hArr|harr|hearts|hellip|iacute|icirc|iexcl|igrave|image|infin|int|iota|iquest|isin|iuml|kappa|lArr|lambda|lang|laquo|larr|lceil|ldquo|le|lfloor|lowast|loz|lrm|lsaquo|lsquo|lt|macr|mdash|micro|middot|minus|mu|nabla|nbsp|ndash|ne|ni|not|notin|nsub|ntilde|nu|oacute|ocirc|oelig|ograve|oline|omega|omicron|oplus|or|ordf|ordm|oslash|otilde|otimes|ouml|para|part|permil|perp|phi|pi|piv|plusmn|pound|prime|prod|prop|psi|quot|rArr|radic|rang|raquo|rarr|rceil|rdquo|real|reg|rfloor|rho|rlm|rsaquo|rsquo|sbquo|scaron|sdot|sect|shy|sigma|sigmaf|sim|spades|sub|sube|sum|sup|sup1|sup2|sup3|supe|szlig|tau|there4|theta|thetasym|thinsp|thorn|tilde|times|trade|uArr|uacute|uarr|ucirc|ugrave|uml|upsih|upsilon|uuml|weierp|xi|yacute|yen|yuml|zeta|zwj|zwnj|";
        if(substr($str, 0, 1) == '#')
        {
            if(substr($str, 1, 1)=='x' || substr($str, 1, 1)=='X')
            {
                if(ctype_xdigit(substr($str, 2)) && hexdec(substr($str, 2))<65536)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            elseif(ctype_digit(substr($str, 1)) && substr($str, 1)<65536)
            {
                return true;
            }
            else
            {   
                return false;
            }
        }
        if(strpos($special_chars, '|'.$str.'|'))
        {
            return true;    
        }
        else
        {
            return false;
        }
    }

    public static function xml2Array($contents = NULL, $encoding = 'UTF-8', $get_attributes = 1, $priority = 'tag')
    {
        if (!$contents) 
        {
            return array();
        }
        if (!function_exists('xml_parser_create'))
        {
            return array ();
        }
        $parser = xml_parser_create('');
        xml_parser_set_option($parser, XML_OPTION_TARGET_ENCODING, $encoding);
        xml_parser_set_option($parser, XML_OPTION_CASE_FOLDING, 0);
        xml_parser_set_option($parser, XML_OPTION_SKIP_WHITE, 1);
        xml_parse_into_struct($parser, trim($contents), $xml_values);
        xml_parser_free($parser);
        if (!$xml_values)
            return array(); 
        $xml_array = array ();
        $parents = array ();
        $opened_tags = array ();
        $arr = array ();
        $current = & $xml_array;
        $repeated_tag_index = array (); 
        foreach ($xml_values as $data)
        {
            unset ($attributes, $value);
            extract($data);
            $result = array ();
            $attributes_data = array ();
            if (isset ($value))
            {
                if ($priority == 'tag')
                    $result = trim($value);
                else
                    $result['value'] = trim($value);
            }
            if (isset ($attributes) && $get_attributes) {
                foreach ($attributes as $attr => $val)
                {
                    if ($priority == 'tag')
                        $attributes_data[$attr] = $val;
                    else
                        $result['attr'][$attr] = $val; //Set all the attributes in a array called 'attr'
                }
            }
            if ($type == "open")
            { 
                $parent[$level -1] = & $current;
                if (!is_array($current) || (!in_array($tag, array_keys($current)))) {
                    $current[$tag] = $result;
                    if ($attributes_data)
                        $current[$tag . '_attr'] = $attributes_data;
                    $repeated_tag_index[$tag . '_' . $level] = 1;
                    if (isset($tag) && $tag && isset($current[$tag])) {
                        $current = & $current[$tag];
                    }
                }
                else
                {
                    if (isset ($current[$tag][0]))
                    {
                        $current[$tag][$repeated_tag_index[$tag . '_' . $level]] = $result;
                        $repeated_tag_index[$tag . '_' . $level]++;
                    }
                    else
                    { 
                        $current[$tag] = array (
                            $current[$tag],
                            $result
                        ); 
                        $repeated_tag_index[$tag . '_' . $level] = 2;
                        if (isset ($current[$tag . '_attr']))
                        {
                            $current[$tag]['0_attr'] = $current[$tag . '_attr'];
                            unset ($current[$tag . '_attr']);
                        }
                    }
                    $last_item_index = $repeated_tag_index[$tag . '_' . $level] - 1;
                    $current = & $current[$tag][$last_item_index];
                }
            }
            elseif ($type == "complete")
            {
                if (!isset ($current[$tag]))
                {
                    $current[$tag] = $result;
                    $repeated_tag_index[$tag . '_' . $level] = 1;
                    if ($priority == 'tag' && $attributes_data) {
                        $current[$tag . '_attr'] = $attributes_data;
                    }
                }
                else
                {
                    if (isset ($current[$tag][0]) && is_array($current[$tag])) {
                        $current[$tag][$repeated_tag_index[$tag . '_' . $level]] = $result;
                        if ($priority == 'tag' && $get_attributes && $attributes_data) {
                            $current[$tag][$repeated_tag_index[$tag . '_' . $level] . '_attr'] = $attributes_data;
                        }
                        $repeated_tag_index[$tag . '_' . $level]++;
                    }
                    else
                    {
                        $current[$tag] = array (
                            $current[$tag],
                            $result
                        ); 
                        $repeated_tag_index[$tag . '_' . $level] = 1;
                        if ($priority == 'tag' && $get_attributes) {
                            if (isset ($current[$tag . '_attr']) && is_array($current[$tag]))
                            { 
                                $current[$tag]['0_attr'] = $current[$tag . '_attr'];
                                unset ($current[$tag . '_attr']);
                            }
                            if ($attributes_data)
                            {
                                $current[$tag][$repeated_tag_index[$tag . '_' . $level] . '_attr'] = $attributes_data;
                            }
                        }
                        $repeated_tag_index[$tag . '_' . $level]++; //0 and 1 index is already taken
                    }
                }
            }
            elseif ($type == 'close')
            {
                $current = & $parent[$level -1];
            }
        }
        return ($xml_array);
    }

    /**
     * @param $contents - The XML text 
     * @param $getAttributes - 1 or 0. If this is 1 the function will get the attributes as well as the tag values.
     * @param $priority - Can be 'tag' or 'attribute'. This will change the way the resulting array sturcture.
     * @return The parsed XML in an array form. Use print_r() to see the resulting array structure.
     * @example  $array =  Xml2Array::parse(file_get_contents('feed.xml'));
     *           $array =  Xml2Array::parse(file_get_contents('feed.xml', 1, 'tag'));
     */
    public static function parse($contents, $getAttributes = 1, $priority = 'attribute') {
        if (! $contents)
            return array ();
        
        if (! function_exists ( 'xml_parser_create' )) {
            return array ();
        }
        
        //Get the XML parser of PHP - PHP must have this module for the parser to work
        $parser = xml_parser_create ( '' );
        //    xml_parser_set_option($parser, XML_OPTION_TARGET_ENCODING, "UTF-8"); # http://minutillo.com/steve/weblog/2004/6/17/php-xml-and-character-encodings-a-tale-of-sadness-rage-and-data-loss
        xml_parser_set_option ( $parser, XML_OPTION_CASE_FOLDING, 0 );
        xml_parser_set_option ( $parser, XML_OPTION_SKIP_WHITE, 0 );
        libxml_clear_errors();
        libxml_use_internal_errors(true);
        xml_parse_into_struct ( $parser, trim ( $contents ), $xmlValues );
        $err = libxml_get_errors();
        if (!empty($err) || xml_get_error_code($parser)) {
            xml_parser_free ( $parser );
            //Bd_Log::warning("xml parse by Xml2Array failed. try to change encode mode. err0: ".var_export($err[0],true),__FILE__,__LINE__,0);
            ini_set('mbstring.substitute_character','0x20');
            $contents = mb_convert_encoding($contents,'utf-8','cp936,utf-8');
            self::replaceHeaderEncoding($contents);
            //删除不可见字符
            $arrNoneStr = null;
            for ($i = 1; $i < 32; ++$i) $arrNoneStr[] = chr($i);
            $arrNoneStr[] = chr(127); //DEL char
            $contents = str_replace($arrNoneStr,' ',$contents);
            $parser = xml_parser_create ( '' );
            xml_parser_set_option ( $parser, XML_OPTION_CASE_FOLDING, 0 );
            xml_parser_set_option ( $parser, XML_OPTION_SKIP_WHITE, 0 );
            libxml_clear_errors();
            libxml_use_internal_errors(true);
            xml_parse_into_struct ( $parser, trim ( $contents ), $xmlValues );
            $err = libxml_get_errors();
            if (empty($err)) {
                $err_code = xml_get_error_code($parser);
                $err = $err_code ? xml_error_string($err_code) : '';
            }
        }
        if (!empty($err)) {
            Bd_Log::warning("xml parse by Xml2Array failed. err0: ".var_export($err[0],true).' from request:'.$_SERVER['REQUEST_URI'],__FILE__,__LINE__,0);
        }
        xml_parser_free ( $parser );
        
        if (! $xmlValues)
            return array ();
            
        //Initializations
        $xmlArray = array ();
        $parents = array ();
        $openedTags = array ();
        $arr = array ();
        
        $current = &$xmlArray; //Refference    
        

        //Go through the tags.
        $repeatedTagIndex = array (); //Multiple tags with same name will be turned into an array
        foreach ( $xmlValues as $data ) {
            unset ( $attributes, $value ); //Remove existing values, or there will be trouble
            

            //This command will extract these variables into the foreach scope
            // tag(string), type(string), level(int), attributes(array).
            extract ( $data ); //We could use the array by itself, but this cooler.
            

            $result = array ();
            $attributesData = array ();
            
            if (isset ( $value )) {
                if ($priority == 'tag')
                    $result = $value;
                else
                    $result ['value'] = trim($value); //Put the value in a assoc array if we are in the 'Attribute' mode
            }//trim added by dongyisu 2010-07-24 14:18
            
            //Set the attributes too.
            if (isset ( $attributes ) && $getAttributes) {
                foreach ( $attributes as $attr => $val ) {
                    if ($priority == 'tag')
                        $attributesData [$attr] = $val;
                    else
                        $result ['attr'] [$attr] = $val; //Set all the attributes in a array called 'attr'
                }
            }
            
            //See tag status and do the needed.
            if ($type == "open") { //The starting of the tag '<tag>'
                $parent [$level - 1] = &$current;
                if (! is_array ( $current ) || (! in_array ( $tag, array_keys ( $current ) ))) { //Insert New tag
                    $current [$tag] = $result;
                    if ($attributesData)
                        $current [$tag . '_attr'] = $attributesData;
                    $repeatedTagIndex [$tag . '_' . $level] = 1;
                    
                    $current = &$current [$tag];
                
                } else { //There was another element with the same tag name
                    

                    if (isset ( $current [$tag] [0] )) { //If there is a 0th element it is already an array
                        $current [$tag] [$repeatedTagIndex [$tag . '_' . $level]] = $result;
                        $repeatedTagIndex [$tag . '_' . $level] ++;
                    } else { //This section will make the value an array if multiple tags with the same name appear together
                        $current [$tag] = array ($current [$tag], $result ); //This will combine the existing item and the new item together to make an array
                        $repeatedTagIndex [$tag . '_' . $level] = 2;
                        
                        if (isset ( $current [$tag . '_attr'] )) { //The attribute of the last(0th) tag must be moved as well
                            $current [$tag] ['0_attr'] = $current [$tag . '_attr'];
                            unset ( $current [$tag . '_attr'] );
                        }
                    
                    }
                    $last_item_index = $repeatedTagIndex [$tag . '_' . $level] - 1;
                    $current = &$current [$tag] [$last_item_index];
                }
            
            } elseif ($type == "complete") { //Tags that ends in 1 line '<tag />'
                //See if the key is already taken.
                if (! isset ( $current [$tag] )) { //New Key
                    $current [$tag] = $result;
                    $repeatedTagIndex [$tag . '_' . $level] = 1;
                    if ($priority == 'tag' && $attributesData) {
                        $current [$tag . '_attr'] = $attributesData;
                    }
                
                } else { //If taken, put all things inside a list(array)
                    if (isset ( $current [$tag] [0] ) && is_array ( $current [$tag] )) { //If it is already an array...
                        

                        // ...push the new element into that array.
                        $current [$tag] [$repeatedTagIndex [$tag . '_' . $level]] = $result;
                        
                        if ($priority == 'tag' && $getAttributes && $attributesData) {
                            $current [$tag] [$repeatedTagIndex [$tag . '_' . $level] . '_attr'] = $attributesData;
                        }
                        $repeatedTagIndex [$tag . '_' . $level] ++;
                    
                    } else { //If it is not an array...
                        $current [$tag] = array ($current [$tag], $result ); //...Make it an array using using the existing value and the new value
                        $repeatedTagIndex [$tag . '_' . $level] = 1;
                        if ($priority == 'tag' && $getAttributes) {
                            if (isset ( $current [$tag . '_attr'] )) { //The attribute of the last(0th) tag must be moved as well
                                

                                $current [$tag] ['0_attr'] = $current [$tag . '_attr'];
                                unset ( $current [$tag . '_attr'] );
                            }
                            
                            if ($attributesData) {
                                $current [$tag] [$repeatedTagIndex [$tag . '_' . $level] . '_attr'] = $attributesData;
                            }
                        }
                        $repeatedTagIndex [$tag . '_' . $level] ++; //0 and 1 index is already taken
                    }
                }
            
            } elseif ($type == 'close') { //End of tag '</tag>'
                $current = &$parent [$level - 1];
            }
        }

        return ($xmlArray);
    }

    public function array2xml($array, $wrap = '', $item = '_item'){
    
        if($wrap) {
            $ret = "<{$wrap}></{$wrap}>\n";
        }

        if(!is_array($array)){
    
            return $ret;
        }
    
        $ret = "<{$wrap}>\n";
        foreach ($array as $key => $value) {

            $r_key = str_replace("#", "_", $key);
            if(is_numeric($r_key) && $item) {
                
                $r_key = $item;
            }
            $r_key = preg_replace('/^\d+/', '',$r_key);
            
            if(is_array($value)){

                $ret .= self::array2xml($value, $r_key);
                continue;
            }

            $ret .= "<{$r_key}><![CDATA[$value]]></{$r_key}>\n";
        }

        $ret .= "</{$wrap}>\n";
        return $ret;
    }

    public static function replaceHeaderEncoding(&$strdata){
        $header = (string)@substr($strdata,0,50);
        $header_len = strlen($header);
        $encoding_len = 9;
        $encoding_pos = stripos($header, 'encoding=');
        if (false === $encoding_pos) {
                return;
        }
        $prefix_start_pos = $encoding_pos + $encoding_len;
        if ($prefix_start_pos >= $header_len) {
                return;
        }
        $prefix_tag = $header[$prefix_start_pos];
        if ($prefix_tag != '\'' && $prefix_tag != '"') {
                return;
        }
        $value_pos = $prefix_start_pos + 1;
        $prefix_end_pos = strpos($header, $prefix_tag, $value_pos);
        if (false === $prefix_end_pos) {
                return;
        }
        $value = substr($header, $value_pos, $prefix_end_pos - $value_pos);
        if (!in_array(strtolower($value), array('gb2312', 'gbk'))) {
                return;
        }
        $strdata = substr($header, 0, $value_pos) . 'utf-8' . substr($strdata, $prefix_end_pos);
    }

    /*
     * Fix htmlspecialchars_decode in HHVM
     */
    public static function hhvm_htmlspecialchars_decode($string, $quotestyle = ENT_COMPAT)
    {
        $tmp = get_html_translation_table(HTML_SPECIALCHARS, $quotestyle);
        return strtr($string, array_flip($tmp));
    }
    /*
     * get Speed.conf
     * by mengdesen
     */
    public static function getSpeedConf($nettype,$browser,$sampling){

        $result = array('keepalive'=>array(),'prefetch'=>0 );
        $speed_conf = Bd_Conf::getAppConf('speed');
        $prefetch_conf = Bd_Conf::getConf('prefetch');

        //get keepalive conf
        if(!empty($speed_conf)){

            if(!( empty($nettype) || empty($browser) )){

                if($browser == 'ucweb applewebkit'){
                    $browser = 'ucwebapplewebkit';
                }

                if(isset($speed_conf['keepalive']['interval'][$nettype][$browser])){
                    $result['keepalive']['interval'] = $speed_conf['keepalive']['interval'][$nettype][$browser];
                }            

                if(isset($speed_conf['keepalive']['duration'][$nettype][$browser])){
                    $result['keepalive']['duration'] = $speed_conf['keepalive']['duration'][$nettype][$browser];
                }            
            }            
        }

        //for keepalive sampling
        if($sampling['match'] && is_array($sampling['vars']['interval']) &&isset($sampling['vars']['interval'][0])){
            $result['keepalive']['interval'] = $sampling['vars']['interval'][0];
        }

        //get prefetch conf
        if(!empty($prefetch_conf)){
            if(isset($prefetch_conf['prefetch']['enabled'])){
                $result['prefetch'] = $prefetch_conf['prefetch']['enabled'];
            }
        }

        return $result;
    }

    public static function getSpeedTest($speedRate){
        $speed = 0;

        //get speed test
        if(!empty($speedRate)){
            $rate = 0;
            for($i = 0, $size = sizeof($speedRate); $i < $size; ++$i){
                if((int) $speedRate[$i] > $rate){
                    $rate = (int) $speedRate[$i];
                }
            }
            $random = rand(1,100);
            if($rate >= $random){
                $speed = 1;
            }
        }

        return $speed;
    }

    /*
     * 提供给https项目使用的域名替换模板插件
     * 异常时返回原url
     * @param unknown $strUrl
     * @return string
     */
    public static function getHttpsHost($strUrl){
        $strReplacedUrl = $strUrl;
        $ishttps = Wise_Utils::isHttps();
        if($ishttps !== 1){
            return $strReplacedUrl;
        }
        if(empty($strUrl)){
            return $strReplacedUrl;
        }
        $arr = parse_url($strUrl);
        //url不符合规范，解析失败
        if(empty($arr) || !is_array($arr)){
            return $strReplacedUrl;
        }
        $strScheme = $arr['scheme'];
        //非http开头的url
        if(empty($strScheme) || $strScheme != 'http'){
            return $strReplacedUrl;
        }
        $strHost = $arr['host'];
        $strDictRst = Wise_Utils::getValueFromDict($strHost,'http_to_https');
        if(empty($strDictRst)){
            return $strReplacedUrl;
        }
        $arr['scheme'] = 'https';
        $arr['host'] = $strDictRst;
        $strBuildUrl = Wise_Utils::antiParerUrl($arr);
        if(!empty($strBuildUrl)){
            $strReplacedUrl = $strBuildUrl;
        }
        return $strReplacedUrl;
    }

    /*
     * 判断当前网络协议是否是https
     * 1为https， 0为http
     * @return int
     */
    public static function isHttps(){
        if(!(isset($_SERVER['HTTP_HTTPS']) && $_SERVER['HTTP_HTTPS'] == 1)){
            return 0;
        }
        return 1;
    }
 
    /*
     * 从字典中获取对于http接口值
     * 字典中有该key，则返回https接口，其他返回原接口
     * @param string $strHost
     * @param string $dictName
     * @return array
     */
    public static function getValueFromDict($strHost, $dictName){
        $filename = "/home/work/odp/conf/backend/search/".$dictName;
        $keyValue = array();
        if(file_exists($filename)){
            $handle  = fopen($filename,"r");
            $content = fread($handle, filesize($filename));
            $result  = explode("\n",$content);
            for($i = 0, $len = count($result); $i < $len; $i++){
                if(!empty($result[$i])){
                    $info = explode("\t",$result[$i]);
                    $keyValue[$info[0]] = $info[1];
                }
            }
            return $keyValue[$strHost];
        }
    }

    /*
     * 根据字典返回值进行重新拼接
     * @param array $parsed
     * @return string
     */
    public static function antiParerUrl($parsed){
        if (! is_array ( $parsed )) {
            return false;
        }

        $uri = isset ( $parsed ['scheme'] ) ? $parsed ['scheme'] . ':' . ((strtolower ( $parsed ['scheme'] ) == 'mailto') ? '' : '//') : '';
        $uri .= isset ( $parsed ['user'] ) ? $parsed ['user'] . (isset ( $parsed ['pass'] ) ? ':' . $parsed ['pass'] : '') . '@' : '';
        $uri .= isset ( $parsed ['host'] ) ? $parsed ['host'] : '';
        $uri .= isset ( $parsed ['port'] ) ? ':' . $parsed ['port'] : '';

        if (isset ( $parsed ['path'] )) {
            $uri .= (substr ( $parsed ['path'], 0, 1 ) == '/') ? $parsed ['path'] : ((! empty ( $uri ) ? '/' : '') . $parsed ['path']);
        }

        $uri .= isset ( $parsed ['query'] ) ? '?' . $parsed ['query'] : '';
        $uri .= isset ( $parsed ['fragment'] ) ? '#' . $parsed ['fragment'] : '';

        return $uri;
    }

    /**
     *@param $pu $puk
     * @return false
     */
    public static function getParamFromPu($pu, $puK) {
        if (!is_string($pu) || !is_string($puK) || $pu === '' || $puK === '') {
            return false;
        }
        
        $pu_array = explode(',', $pu);
        foreach ($pu_array as $v) {
            $tmpArr = explode('@', $v);
            $key = isset($tmpArr[0]) ? $tmpArr[0] : null;
            if ($key === $puK) {
                return isset($tmpArr[1]) ? $tmpArr[1] : null;
            }
        }
        
        return false;
    }

    /**
     * 语音标记
     *@param $pu
     *@return int  1/0
     */
    public static function isVoiceSearch($pu) {
        $voice_search = 0;
        $csrc = Wise_Utils::getParamFromPu($pu, 'csrc');
        $substr = strstr($csrc, '_voice');
        if ($substr && $substr == '_voice') {
            $voice_search = 1;
        }
        return $voice_search;
    }
    
    /**
    * 获取字串中key对应的value
    * @param $string,   $exp, $sep, $key
    *     示例 a=1; b=2   ;     =     a
    * @return value or null
    */
    public static function getValueByKey($string, $exp, $sep, $key) {
        if (!is_string($string) || !is_string($key) || !is_string($exp) || !is_string($sep)
        || $string === '' || $key === '' || $exp === '' || $sep === '') {
            return false;
        }
         
        $seg_array = explode($exp, $string);
        foreach ($seg_array as $seg) {
            $tmpArr = explode($sep, trim($seg));
            $tmpKey = isset($tmpArr[0]) ? $tmpArr[0] : null;
            if ($tmpKey === $key) {
                return isset($tmpArr[1]) ? $tmpArr[1] : null;
            }
        }
        return null;
    }
}
