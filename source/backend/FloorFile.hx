package backend;

import haxe.Json;
import sys.io.File;
import entitys.GameData;

enum FloorItems
{
	ROOM;
	ENEMY;
	ITEM;
}

class FloorFile
{
	public static function loadFloorFromFile(filePath:String):Map<Int, Map<FloorItems, Array<Dynamic>>>
	{
		var floorData:Map<Int, Map<FloorItems, Array<Dynamic>>> = new Map<Int, Map<FloorItems, Array<Dynamic>>>();

		var fileContent:String = File.getContent(Paths.data("test",Json_File));
		var jsonData:FloorJSON = Json.parse(fileContent);

		for (room in jsonData.rooms)
		{
			var roomId:Int = room.id;
			var roomEnemies:Array<Dynamic> = room.enemies;
			var roomItems:Array<Dynamic> = room.items;

			var roomData:Map<FloorItems, Array<Dynamic>> = new Map<FloorItems, Array<Dynamic>>();
			roomData.set(FloorItems.ENEMY, roomEnemies);
			roomData.set(FloorItems.ITEM, roomItems);
			floorData.set(roomId, roomData);
		}

		return floorData;
	}
}
