package view;

import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.events.Event;
import zygame.display.DisplayObjectContainer;
import zygame.components.ZButton;
import zygame.display.Image;
import openfl.events.MouseEvent;
import ad.H5Api;

class LoginView extends DisplayObjectContainer{

    private var _callback:Bool->Void;

    public function new(call:Bool->Void){
        super();
        _callback = call;
    }

    override public function onInit():Void
    {
        super.onInit();
        var bg:Sprite = new Sprite();
        this.addChild(bg);
        bg.graphics.beginFill(0,0.5);
        bg.graphics.drawRect(0,0,getStageWidth(),getStageHeight());
        bg.graphics.endFill();

        var loginbg:Image = new Image(Assets.getBitmapData("4399login/4399_bg.png"));
        this.addChild(loginbg);
        loginbg.x = getStageWidth()/2 - loginbg.width/2;
        loginbg.y = getStageHeight()/2 - loginbg.height/2;

        //按钮
        var yklogin:ZButton = ZButton.createButton(Assets.getBitmapData("4399login/4399_guest.png"));
        this.addChild(yklogin);
        yklogin.x = loginbg.x + loginbg.width/2 - yklogin.width/2 - 30 - yklogin.width/2;
        yklogin.y = loginbg.y + loginbg.height - 100;

        //登录
        var loginid:ZButton = ZButton.createButton(Assets.getBitmapData("4399login/4399_id.png"));
        this.addChild(loginid);
        loginid.y = yklogin.y;
        loginid.x = loginbg.x + loginbg.width/2 - loginid.width/2 + 30 + loginid.width/2;

        this.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):Void{
            if(e.target == loginid)
            {
                H5Api.login(function(data:Dynamic):Void{
                    var islogin:Bool = H5Api.isLogin();
                    if(islogin)
                        parent.removeChild(this);
                    _callback(islogin);
                });
            }
            else if(e.target == yklogin)
            {
                parent.removeChild(this);
                _callback(true);
            }
        });
    }
}