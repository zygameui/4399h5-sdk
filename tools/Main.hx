import sys.FileSystem;

class Main {
	public static var exts:Array<String> = "htm,html,js,css,jpg,jpeg,gif,png,mp3,ogg,m4a,xml,csv,dat,atf,json,plist,wav,thm,fnt,exportjson,ttf,tmx,exml,datagz,jsgz,memgz,unityweb,scml,scon,ani,atlas,lani,lh,lmat,lm,sk,ls,lav,wasm,pck,fui,ltc,prefab,part,ltcb,lamat,txt,dbbin".split(",");

	static function main() {
        trace("开始检查");
		check(Sys.args()[0]);
	}

	public static function check(dirfile:String):Void {
        if(!FileSystem.exists(dirfile)){
            trace("文件夹不存在：",dirfile);
            return;
        }
		var array:Array<String> = FileSystem.readDirectory(dirfile);
		for (file in array) {
			if (FileSystem.isDirectory(dirfile + "/" + file)) {
				check(dirfile + "/" + file);
			} else {
				var ext = file.substr(file.lastIndexOf(".") + 1);
				if (exts.indexOf(ext) == -1 || file.indexOf(" ") != -1) {
					trace("需要过滤：" + file);
				}
			}
		}
	}
}
