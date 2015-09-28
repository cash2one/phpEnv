<?php
/** 
 * SAF主函数
 * @author cuichao02 
 * @date 2011/02/21
 */
class Saf_SmartMain{
    const DICT_READ = 1;                     //当前数据可读
    const DICT_WRITE = 3;                     //当前数据可读写
    const REQUEST_PARAM = 'request_param';  //字典：接收到的POST GET数据
    const USER_INFO = 'user_info';            //字典：登录者用户信息
    const PUBLIC_PARAM = 'public_param';     //字典：公共字典
    const LOG_NOTICE = 'log_notice';        //字典：要保存的LOG
    const SAVE_PASSPORT = 'save_passport';  //字典：session回写数据
    //字典仓库
    private static $arrDict = array(
        self :: REQUEST_PARAM   => array('data' => array(), 'status' => self :: DICT_READ),  //CGI数据
        self :: USER_INFO       => array('data' => array(), 'status' => self :: DICT_READ),     //SESSION数据
        self :: SAVE_PASSPORT   => array('data' => array(), 'status' => self :: DICT_WRITE), //向pass回写数据
        self :: PUBLIC_PARAM    => array('data' => array(), 'status' => self :: DICT_WRITE), //公用变量
        self :: LOG_NOTICE      => array('data' => array(), 'status' => self :: DICT_WRITE), //LOG数据
    );
    //saf内部LOG，调试使用,预订义3个级别，应用方可以自己加级别，不做限制。
    private static $arrSafLog = array(
        'level_0' => //saf核心函数报错SmartMain类(SmartMain核心函数报错，多数是权限方面。使用范围:以"__"开头的函数)
            array(0 =>array('funName'=>'类名::函数', 'line'=>'行数', 'message'=>'内容')),
        'level_1' => //saf内部使用报错(SmartMain类使用上的报错， 多数是参数格式，核心数据返回值出错。使用范围:SmartMain类)
            array(0 =>array('funName'=>'类名::函数', 'line'=>'行数', 'message'=>'内容')),
        'level_2' => //saf外部应该报错(主要是base文件夹中的类报错，多数是逻辑、通信、数据校验。使用范围:base文件夹中的类)
            array(0 =>array('funName'=>'类名::函数', 'line'=>'行数', 'message'=>'内容')),
    );

    //saf通用流程可裁剪，目前有通用流程cgi,session和log
    //cgi功能:获取POST和GET参数，并根据ie和oe参数做编码转换，执行Hook：cgiAction;
    //session功能:请求执行前Passport登陆功能，执行Hook：userInfoAction和savePassportAction;
    //log功能:请求结束打印Notice日志
    //通用流程可配置，App域的配置覆盖全局配置。
    private static $arrCommonAction = array(
        'cgi'     => 1, 
        'session' => 1,
        'log'     => 1,
    );

    /**
     * @brief 初始化通用流程，App域的配置覆盖全局配置，若用户为提供配置，则默认开启流程
     *
     * @return  private static function 
     * @retval   
     * @see 
     * @note 
     * @author luhaixia
     * @date 2012/03/28 14:16:42
    **/
    private static function initCommonAction(){
        $arrConf = Bd_Conf::getAppConf('saf/action');
        if(empty($arrConf)){
            $arrConf = Bd_Conf::getConf('saf/action');
        }
        foreach(self::$arrCommonAction as $key => $value){
            if(isset($arrConf[$key])){
                self::$arrCommonAction[$key] = intval($arrConf[$key]) ? 1 : 0;
            }
        }
    }

    /**
     * 设置saf内部log
     * @param 消息内容 $message
      * @param 级别 $level 应用方可以随意增加级别，不做限制，系统默认使用3级
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function setSafLog($message, $level) {
            $trace = debug_backtrace();
            self :: $arrSafLog['level_' . $level][] = array( 'funName' => $trace[1]['class'] . '::' . $trace[1]['function'], 
                                                             'line'    => $trace[0]['line'], 
                                                             'message' => $message );
    }
    /**
     * 获得saf内部log
     * @return array()
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function getSafLog() {
        return self :: $arrSafLog;
    }
    //获得字典
    private static function __getDict($type) {
        if ( self :: DICT_READ === (self :: $arrDict[$type]['status'] & self :: DICT_READ) ) {
            return self :: $arrDict[$type]['data'];
        }else {
            Saf_SmartMain :: setSafLog("没有读取字典(" . $type . ")的权限", 0);
            return false;
        }
    }
    //存储字典
    private static function __setDict($type, $arrValue) {
        if ( !is_array($arrValue) ) {
            Saf_SmartMain :: setSafLog("当前写入字典的变量不是数组(" . var_export($arrValue, true) . ")", 0);
            return false;
        }
        if ( self :: DICT_WRITE === (self :: $arrDict[$type]['status'] & self :: DICT_WRITE) ) {
            self :: arrSuperMerge( self :: $arrDict[$type]['data'], $arrValue );
            return true;
        }
            Saf_SmartMain :: setSafLog("没有写字典({$type})的权限", 0);
            return false;
    }
    /**
     * 获得CGI数据
     * @return 失败false, 成功array()
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function getCgi()
    {
        return self :: __getDict(self :: REQUEST_PARAM);
    }
    /**
     * 设置CGI数据
     * @return 失败false, 成功array()
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function setCgi($arrValue)
    {
        if ( self :: __setDict(self :: REQUEST_PARAM, $arrValue) === true )    {
            return self :: __getDict(self :: REQUEST_PARAM);
        }else {
            Saf_SmartMain :: setSafLog("保存CGI数据时出错", 1);
            return false;
        }
    }

    /** 
     * @brief 去掉指定key的cgi参数
     *
     * @params  array('key1', 'key2');
     * @return  失败false，成功true;
     * @see 
     * @note 
     * @author luhaixia
     * @date 2012/05/08 14:29:54
    **/
    public static function unsetCgi($arrKeys){
        if ( self :: DICT_WRITE === (self :: $arrDict[self::REQUEST_PARAM]['status'] & self :: DICT_WRITE) ){
            foreach($arrKeys as $key){
                if(isset(self::$arrDict[self::REQUEST_PARAM]['data'][$key])){
                    unset(self :: $arrDict[self::REQUEST_PARAM]['data'][$key]);
                }   
            }   
            return true;
        }else{
            Saf_SmartMain :: setSafLog("没有写字典(REQUEST_PARAM)的权限", 0); 
            return false;
        }   

    }

    //接收用户Cgi参数
    public static function checkCgi()
    {
        if(!self::$arrCommonAction['cgi']){ //是否被裁剪
            return true;
        }
        //开放写权限
        self :: $arrDict[self :: REQUEST_PARAM]['status'] = self :: DICT_WRITE;
        self :: setCgi( Saf_Base_Cgi :: getRequest() );
        Saf_Base_Hook :: cgiHook();
        //关闭写权限
        self :: $arrDict[self :: REQUEST_PARAM]['status'] = self :: DICT_READ;
    }
    /**
     * 获得用户信息数据
     * @return 失败false, 成功array()
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function getUserInfo()
    {
        return self :: __getDict(self :: USER_INFO);
    }
    /**
     * 设置用户信息数据
     * @return 失败false, 成功array()
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function setUserInfo($arrValue)
    {
        //PS/WISE 用户搜索记录同步 根据uid+key md5生成秘钥,  wangdazhuo@baidu.com 2015-02-01 重要
        if (isset($arrValue['uid']) && !empty($arrValue['uid'])) {
            $str = $arrValue['uid'].'bdwise';
            $md5 = md5($str);
            $secret = $md5[2].$md5[4].$md5[11].$md5[0].$md5[10].$md5[5];
            $arrValue['usecret'] = $arrValue['uid'].'_'.$secret;
        }
        if ( self :: __setDict(self :: USER_INFO, $arrValue) === true )    {
            return self :: __getDict(self :: USER_INFO);
        } else {
            Saf_SmartMain :: setSafLog("保存用户信息时出错", 1);
            return false;
        }
    }
    //检查用户SESSION
    public static function checkSession()
    {
        if(!self::$arrCommonAction['session']){//是否被裁剪
            return true;
        }

    //都是为了速度统计
    $timer = null;
    if (class_exists('Ap_Registry')) {
        $timer = Ap_Registry::get('timer');
        if (is_object($timer)) {
            $timer->stop('processTime');
            $timer->start('requestTime');
        } else {
            $timer = null;
        }
    }
        $arrUserInfo = Saf_Base_Session :: checkLogin();
    if ($timer) {
        $timer->start('processTime');
        $timer->stop('requestTime');
    }

        if ( $arrUserInfo === false){
            return false;
        }
        //开放写权限
        self :: $arrDict[self :: USER_INFO]['status'] = self :: DICT_WRITE;
        $re = self :: setUserInfo( $arrUserInfo );
        Saf_Base_Hook :: userInfoHook();
        //关闭写权限
        self :: $arrDict[self :: USER_INFO]['status'] = self :: DICT_READ;
    }

    /**
     * 获得将要存储pass port数据
     * @return 失败false, 成功array()
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function getSavePassport()
    {
        return self :: __getDict(self :: SAVE_PASSPORT);
    }
    /**
     * 设置将要保存在passport的数据
     * @param int $bit 设置第几位
     * @param int $v   设置值
     * @return 失败false, 成功array()
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function setSavePassport($bit, $v)
    {
        $arrValue[$bit]  = $v;
        if ( self :: __setDict(self :: SAVE_PASSPORT, $arrValue) === true ) {
            return self :: __getDict(self :: SAVE_PASSPORT);
        }else {
            Saf_SmartMain :: setSafLog("设置到passport字典数据报错(" . var_export($arrValue, true) . ")", 1);
            return false;
        }
    }
    //保存到passPort
    public static function savePassport()
    {
        if(!self::$arrCommonAction['session']){//被裁剪
            return true;
        }
        Saf_Base_Hook :: savePassportHook();
        return Saf_Base_Session :: saveModDatat();
    }
    /**
     * 获得LOG数据
     * @return 失败false, 成功array()
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function getLogNotice()
    {
        return self :: __getDict(self :: LOG_NOTICE);
    }
    /**
     * 设置LOG数据
     * @param array(key=>value)
     * @return 失败false, 成功array()
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function setLogNotice($arrValue)
    {
        if ( self :: __setDict(self :: LOG_NOTICE, $arrValue) === true ) {
            return self :: __getDict(self :: LOG_NOTICE);
        }else {
            Saf_SmartMain :: setSafLog("设置到log字典数据报错(" . var_export($arrValue, true) . ")", 1);
            return false;
        }
    }
    /**
     * 设置LOG数据
     * @param array(key=>value)
     * @return 失败false, 成功array()
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function unsetLogNotice($arrKeys)
    {
        if ( self :: DICT_WRITE === (self :: $arrDict[self::LOG_NOTICE]['status'] & self :: DICT_WRITE) ){
            foreach($arrKeys as $key){
                if(isset(self::$arrDict[self::LOG_NOTICE]['data'][$key])){
                    unset(self :: $arrDict[self::LOG_NOTICE]['data'][$key]);
                }   
            }   
        }else {
            Saf_SmartMain :: setSafLog("设置到log字典数据报错(" . var_export($arrKeys, true) . ")", 1);
            return false;
        }
    }
    //保存到日志中
    public static function saveLogNotice()
    {
        
        if(!self::$arrCommonAction['log']){//被裁剪
            return true;
        }
        Saf_Base_Hook :: saveLogHook();
        $arrArgs = Saf_SmartMain :: getLogNotice() ;
        if ( $arrArgs === false ) {
            return false;
        }
        Saf_Base_Log  :: addLogNotice($arrArgs);
    }
    /**
     * 获得公共字典数据
     * @return 失败false, 成功array()
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function getPublic()
    {
        return self :: __getDict(self :: PUBLIC_PARAM);
    }
    /**
     * 设置公共字典数据
     * @return 失败false, 成功array()
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function setPublic($arrValue)
    {
        if ( self :: __setDict(self :: PUBLIC_PARAM, $arrValue) === true )    {
            return self :: __getDict(self :: PUBLIC_PARAM);
        }else {
            Saf_SmartMain :: setSafLog("保存公共字典数据时出错", 1);
            return false;
        }
    }
    /**
     * adapter[Bingo]：SAF开始入口，检查CGI，SESSION信息
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function adapterStart()
    {
        self :: initCommonAction(); 
        self :: checkCgi();
        self :: checkSession();
    }
    /**
     * adapter[Bingo]： SAF结束，回写SESSION，增加LOG信息
     * @author cuichao02 
     * @date 2011/02/21
     */
    public static function adapterEnd()
    {
        self :: savePassport();
        self :: saveLogNotice();
    }
    /**
     * 增强多维数组合并
     *
     * @param arrat &$arrHistory
     * @param array &$arrInputValue
     * @return 失败false,
     */
    private function arrSuperMerge(&$arrHistoryLog, &$arrValue)
    {
        if (!is_array($arrHistoryLog)) {
            $arrHistoryLog = array();
        }
        foreach ($arrValue as $k=>&$v)
        {
            if (!is_array($v)) {
                $arrHistoryLog[$k] = $v;
            }else {
                self :: arrSuperMerge($arrHistoryLog[$k], $v);
            }
        }
    }
    public static function setCgiStart($arrParams){
        //开放写权限
        self :: $arrDict[self :: REQUEST_PARAM]['status'] = self :: DICT_WRITE;
        $arrLastCgi = self::getCgi();

        if(is_array($arrParams)){
            foreach($arrParams as $key => $value){
                self :: $arrDict[self :: REQUEST_PARAM]['data'][$key] = $value;
            }
        }else{
            self :: setCgi($arrParams);
        }
        return $arrLastCgi;
    }
}
