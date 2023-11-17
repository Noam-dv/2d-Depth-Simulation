package states;

import util.*;
import backend.*;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMatrix;
import gfx.*;
import shaders.FlxRuntimeShader;
import shaders.Shaders;
import flixel.util.FlxSort;
import entitys.*;
import flixel.math.FlxPoint;
import flixel.math.FlxMath;
import flixel.FlxSprite;

class PlayState extends FlxState
{
	public var byte:Byte;
	private var playerFollow:FlxPoint;
	override public function create()
	{
		super.create();

		playerFollow = new FlxPoint();

		var bg = new FlxSprite().loadGraphic(Paths.graphic("placeholders/bgtest1",Image));
		bg.screenCenter();
		bg.scale.set(0.65,0.65);
		add(bg);

		byte = new Byte();
		add(byte);

		
		FlxG.camera.bgColor = flixel.util.FlxColor.WHITE;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		playerFollow.set(byte.chest.getGraphicMidpoint().x + byte.camOffset.x, byte.chest.getGraphicMidpoint().y);
		FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, playerFollow.x, elapsed * 7.5);
	}
}
