package states;

import backend.*;
import entitys.*;
import flixel.FlxG;
import flixel.FlxSprite;
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

class PlayState extends NLevel
{
	public var byte:Byte;

	private var playerFollow:FlxPoint;

	override public function create()
	{
		super.create();

		playerFollow = new FlxPoint();

		background = RoomUtil.background("placeholders/bgtest");
		add(background);

		byte = new Byte();
		add(byte);

		forground = RoomUtil.forground("placeholders/bgtest");
		add(forground);

		FlxG.camera.bgColor = flixel.util.FlxColor.WHITE;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.watch.addQuick("player.coords", [byte.mouth.x, byte.mouth.y]);
		playerFollow.set(byte.chest.getGraphicMidpoint().x + byte.camOffset.x, byte.chest.getGraphicMidpoint().y);
		FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, playerFollow.x, elapsed * 7.5);
	}
}
