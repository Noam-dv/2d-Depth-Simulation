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
import backend.FloorFile.FloorItems;

class PlayState extends NLevel {
    public var byte:Byte;
    private var playerFollow:FlxPoint;
    private var loadedRoomSprites:Array<NSprite>;

	public static var instance:PlayState;

    override public function create() {
        super.create();

		instance = this;
        playerFollow = new FlxPoint();
        loadedRoomSprites = []; 

        var roomId:Int = 1;
        var floorData:Map<Int, Map<FloorItems, Array<Dynamic>>> = FloorFile.loadFloorFromFile("test"); 
        loadedRoomSprites = RoomUtil.loadRoomData(roomId, floorData, instance);

        for(_s in loadedRoomSprites) add(_s);
        
        byte = new Byte();
        add(byte);

        addFG();

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
