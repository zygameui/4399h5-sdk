package ad;

import js.ad.base.BaseVideoAd;
import ad.H5Api;
import zygame.utils.Lib;

class GameH5Video extends BaseVideoAd {
	private var remain:Int = 0;

	#if gad
	public var gad:CoreAd;
	#end

	override public function init():Void {
		Lib.setTimeout(loadVideo,2000);
		#if gad
		if(gad == null)
		{
			gad = new CoreAd();
		}
		#end
	}

	/**
	 * 广告是否可以使用，默认为true
	 * @return Bool
	 */
	override public function isReady():Bool {
		// return remain > 0;
		return true;
	}

	/**
	 * 开始展示视频广告
	 */
	override public function show():Void {
		if (isReady()) {
			if (H5Api != null && H5Api.playAd != null) {
				H5Api.playAd(function(data:Dynamic):Void {
					switch (data.code) {
						case 10000:
							this.onVideoStart();
						case 10001:
							this.onReward(true);
						default:
							this.onReward(false);
					}
					remain --;
					loadVideo();
				});
			}
		} else {
			onError("已无法再次展示！");
			loadVideo();
		}
	}

	/**
	 * 加载视频
	 */
	public function loadVideo():Void {
		// #if !debug
		trace("加载视频广告！");
		if (H5Api != null && H5Api.canPlayAd != null) {
			try {
				H5Api.canPlayAd(function(data:Dynamic):Void {
					remain = data.remain;
					trace("视频数据：" + data);
				});
			} catch (e:Dynamic) {
				trace("Error:广告载入失败!");
			}
		}
		else
		{
			trace("H5Api未准备好！1秒后重试！");
			Lib.setTimeout(loadVideo,1000);
		}
		// #end
	}
}
