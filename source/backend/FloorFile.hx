package backend;

import entitys.GameData;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;

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

		var fileContent:String = File.getContent(filePath);
		var parsedDynamic:Dynamic = Json.parse(fileContent);

		if (parsedDynamic != null && Reflect.hasField(parsedDynamic, "rooms"))
		{
			for (room in Reflect.field(parsedDynamic, "rooms"))
			{
				var roomData:RoomData = parseRoomData(room);

				var enemyData:Array<Dynamic> = Reflect.field(room, "enemies");
				var itemData:Array<Dynamic> = Reflect.field(room, "items");

				if (enemyData != null)
					roomData.enemies = parseEnemyOrItemData(enemyData, EnemyData);
				if (itemData != null)
					roomData.items = parseEnemyOrItemData(itemData, ItemData);

				floorData.set(roomData.id, roomDataToMap(roomData));
			}
		}

		return floorData;
	}

	private static function parseRoomData(room:Dynamic):RoomData
	{
		var roomData:RoomData = new RoomData(room.id);
		return roomData;
	}

	private static function parseEnemyOrItemData(data:Array<Dynamic>, DataType:Class<Dynamic>):Array<Dynamic>
	{
		var dataArray:Array<Dynamic> = [];
		for (item in data)
		{
			var parsedData:Dynamic = cast(item, DataType);
			dataArray.push(parsedData);
		}
		return dataArray;
	}

	private static function roomDataToMap(roomData:RoomData):Map<FloorItems, Array<Dynamic>>
	{
		var map:Map<FloorItems, Array<Dynamic>> = new Map<FloorItems, Array<Dynamic>>();
		map.set(FloorItems.ENEMY, roomData.enemies);
		map.set(FloorItems.ITEM, roomData.items);
		return map;
	}
}
