package ad;

@:native("window.h5api")
extern class H5Api {

    /**
     * 展示引导下载面板
     * @param callback 奖励回调，如果是在线玩APP打开，则可以直接领取
     */
    public static function showGuide(callback:Void->Void):Void;

    /**
     * 获取视频广告是否可以播放
     * @param callback 
     */
    public static function canPlayAd(callback:Dynamic->Void):Void;
    
    /**
     * 播放视频接口
     * @param callback 
     */
    public static function playAd(callback:Dynamic->Void):Void;

    /**
     * 展示排行榜
     */
    public static function showRankList():Void;

    /**
     * 提交排行榜数据
     * @param s 
     * @param callback 
     */
    public static function submitRankScore(rankid:Int,score:Float,callback:Dynamic->Void = null):Void;

    /**
     * 登录API
     * @param call 
     */
    public static function login(call:Dynamic->Void):Void;

    /**
     * 是否已经登录
     * @return Bool
     */
    public static function isLogin():Bool;

}