package util;

import flixel.util.FlxSave;

import openfl.utils.Assets;
import lime.utils.Assets as LimeAssets;
import gfx.*;
#if sys
import sys.io.File;
import sys.FileSystem;
#end
import flixel.util.FlxSort;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.FlxG;

class Util 
{
	public static inline function init_camera(cam:flixel.FlxCamera, isDefault:Bool = false, bgcolor:FlxColor = FlxColor.BLACK, bgcoloralpha:Int = 0) {
		cam = new FlxCamera();

		if(isDefault) {
			FlxG.cameras.reset(cam);
			FlxG.cameras.setDefaultDrawTarget(cam, true);
		}else{
			FlxG.cameras.add(cam, false);
		}
		cam.bgColor = bgcolor;
		cam.bgColor.alpha = bgcoloralpha;
	}
	public static inline function byZ(Order:Int, Obj1:NSprite, Obj2:NSprite):Int {
		return FlxSort.byValues(Order, Obj1.z, Obj2.z);
	}
}