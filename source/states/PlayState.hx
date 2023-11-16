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

class PlayState extends FlxState
{
	public var byte:Byte;

	override public function create()
	{
		super.create();

		byte = new Byte();
		add(byte);

		FlxG.camera.bgColor = flixel.util.FlxColor.WHITE;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed) {
            if (FlxG.mouse.x >= byte.x && FlxG.mouse.x <= byte.x + byte.width &&
                FlxG.mouse.y >= byte.y && FlxG.mouse.y <= byte.y + byte.height) {

                var mouseXDir:Float = FlxG.mouse.x - byte.x;
                var mouseYDir:Float = FlxG.mouse.y - byte.y;

                var length:Float = Math.sqrt(mouseXDir * mouseXDir + mouseYDir * mouseYDir);
                mouseXDir /= length;
                mouseYDir /= length;
                byte.addForce(-mouseXDir * 5, -mouseYDir * 5);
            }
        }
	}
}
