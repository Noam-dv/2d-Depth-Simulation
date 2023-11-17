package entitys;

import backend.*;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxMatrix;
import flixel.math.FlxPoint;
import flixel.util.FlxSort;
import gfx.*;
import shaders.FlxRuntimeShader;
import shaders.Shaders;
import util.*;

class RoomUtil
{
	public static function background(prefix:String):NSprite
	{
		var bg = new NSprite(0, 0, Paths.graphic('$prefix-background', Image));
		bg.screenCenter();
		return bg;
	}

	public static function forground(prefix:String):NSprite
	{
		var fg = new NSprite(0, 0, Paths.graphic('$prefix-forground', Image));
		fg.screenCenter();
		return fg;
	}
}
