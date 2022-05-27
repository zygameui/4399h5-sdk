import ad.H5Api;
import haxe.Json;

/**
 * 4399游戏核心处理
 */
class Game4399Core {
	private static var isLogin:Bool = false;

	/**
	 * 登录接口
	 * @param loginCall
	 */
	public static function login(loginCall:Bool->Void):Void {
		if (H5Api == null)
			return;
		// 需要登录权限时处理
		#if (!debug && needlogin)
		try {
			if (!ad.H5Api.isLogin() && !isLogin) {
				zygame.core.Start.current.addChild(new view.LoginView(function(bool:Bool):Void {
					isLogin = bool;
					loginCall(bool);
				}));
			} else
				loginCall(true);
		} catch (e:Dynamic) {
			loginCall(true);
		}
		#else
		loginCall(true);
		#end
	}

	/**
	 * 存档实现
	 * @param data
	 */
	public static function saveData(data:Dynamic, onSuccess:Void->Void, onError:String->Void):Void {
		if (H5Api == null)
			return;
		try {
			if (!ad.H5Api.isLogin()) {
				onError("未登录账号，或者账号异常");
				return;
			}
		} catch (e:Dynamic) {
			onError("未登录账号，或者账号异常");
		}
		untyped window.h5api.save({
			more: false,
			type: "write",
			title: "save",
			data: Json.stringify(data),
			callback: function(res) {
				if (res.code == 1000) {
					onSuccess();
				} else
					onError(res.msg);
			}
		});
	}

	/**
	 * 存档读取
	 * @param callback
	 */
	public static function readData(onSuccess:Dynamic->Void, onError:String->Void):Void {
		if (H5Api == null){
			onError("未登录账号，或者账号异常");
			return;
		}
		try {
			if (!ad.H5Api.isLogin()) {
				onError("未登录账号，或者账号异常");
				return;
			}
		} catch (e:Dynamic) {
			onError("未登录账号，或者账号异常");
			return;
		}
		untyped window.h5api.save({
			more: false,
			type: "read",
			callback: function(res) {
				trace("4399api：",res);
				if (res == null) {
					onError("读档失败！");
					return;
				}
				if (res.code == 1000) {
					onSuccess(res.data);
				} else
					onError(res.msg);
			}
		});
	}
}
