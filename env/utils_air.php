<?php


    function toJson($content, $incharset='utf-8', $outcharset="gbk") {
        //不支持单个文字
        if(is_string($content))
        {
            return iconv($incharset, $outcharset, $content);
        } elseif (is_array($content)) {
            foreach ($content as $key => $val)
            {
                $content[$key] = toJson($val);
            }
            return $content;
        } elseif (is_object($content)) {
            $vars = get_object_vars($content);
            foreach ($vars as $key => $val)
            {
                $content->$key = toJson($val);
            }
            return $content;
        } else {
            return $content;
        }
    }
	function struct_to_array($item) {                        
		if(!is_string($item)) {                                
			$item = (array)$item;                                
			foreach ($item as $key=>$val){                       
				$item[$key]  =  struct_to_array($val);             
			}                                                    
		}                                                      
		return $item;                                          
	}                                                        

    class Utils_Tools {

        /**
         * 
         */
        public static function array_2_other_charset_json($content, $incharset='utf-8', $outcharset="gbk") {
            return toJson($content, $incharset, $outcharset);
        }

		//读取xml文件返回php数组
		public static function xml_to_array($xmlpath){                                                        
			$xml = file_get_contents($xmlpath,true);                         
			$xml = preg_replace('/<!--.*-->/','',$xml);
			$array = (array)(simplexml_load_string($xml,'SimpleXMLElement', LIBXML_NOCDATA));         
			foreach ($array as $key=>$item){                       
				$array[$key]  =  struct_to_array((array)$item);      
			}                                                      
			return $array;                                        
		}                                                        

		
		public static function send_post($url, $post_data) {
		  $options = array(
			  'http' => array(
			  'method' => 'POST',//or GET
			  'header' => 'Content-type:application/x-www-form-urlencoded',
			  'content' => $post_data,
			  'timeout' => 15 * 60 // 超时时间（单位:s）
			  )
		  );
		  $context = stream_context_create($options);
		  $result = file_get_contents($url, false, $context);
		  return $result;
		 }
	
		public static function objectToArray($e){
			$e=(array)$e;
			foreach($e as $k=>$v){
				if( gettype($v)=='resource' ) return;
				if( gettype($v)=='object' || gettype($v)=='array' )
					$e[$k]=(array)objectToArray($v);
			}
			return $e;
		 }

		public static function get_real_ip(){ 
			$ip=false; 
			if(!empty($_SERVER['HTTP_CLIENT_IP'])){ 
				$ip=$_SERVER['HTTP_CLIENT_IP']; 
			}
			if(!empty($_SERVER['HTTP_X_FORWARDED_FOR'])){ 
				$ips=explode (', ', $_SERVER['HTTP_X_FORWARDED_FOR']); 
				if($ip){ array_unshift($ips, $ip); $ip=FALSE; }
				for ($i=0; $i < count($ips); $i++){
					if(!eregi ('^(10│172.16│192.168).', $ips[$i])){
						$ip=$ips[$i];
						break;
					}
				}
			}
			return ($ip ? $ip : $_SERVER['REMOTE_ADDR']); 
		}


    }

?>
