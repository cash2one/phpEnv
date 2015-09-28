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
			$array = (array)(simplexml_load_string($xml));         
			foreach ($array as $key=>$item){                       
				$array[$key]  =  struct_to_array((array)$item);      
			}                                                      
			return $array;                                        
		}                                                        


    }

?>
