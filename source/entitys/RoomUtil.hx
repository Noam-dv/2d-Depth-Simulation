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
import backend.FloorFile.FloorItems;
import states.PlayState;

class RoomUtil
{
    public static function loadRoomData(roomId:Int, floorData:Map<Int, Map<FloorItems, Array<Dynamic>>>, playState:PlayState):Array<NSprite> {
        var roomData:Map<FloorItems, Array<Dynamic>> = floorData.get(roomId);
        var loadedSprites:Array<NSprite> = [];

        if (roomData != null) {
            var bgList:Array<Dynamic> = roomData.get(FloorItems.ROOM);
            if (bgList != null) {
                for (bgData in bgList) {
                    var bg:NSprite = background("placeholders/bgtest");
                    loadedSprites.push(bg);
                    bg.x = bgData.x;
                    bg.y = bgData.y;
                    playState.addSpr(bg);

                    var fg:NSprite = forground("placeholders/bgtest");
                    loadedSprites.push(fg);
                    fg.x = bgData.x;
                    fg.y = bgData.y;
                    playState.addInfront(fg);
                }
            }

            var enemyList:Array<Dynamic> = roomData.get(FloorItems.ENEMY);
            if (enemyList != null) {
                for (enemyJSON in enemyList) {
                    // var enemyType:String = enemyJSON.type;
                    // var enemy:Enemy = loadEnemy(enemyType);
                    // enemy.x = enemyJSON.x;
                    // enemy.y = enemyJSON.y;
                    // add(enemy);
                }
            }
        }

        return loadedSprites;
    }

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
