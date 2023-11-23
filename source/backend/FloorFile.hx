package backend;

import entitys.GameData;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;

enum FloorItems {
    ROOM;
    ENEMY;
    ITEM;
}
class FloorFile {
    public static function load(filePath:String):Map<Int, Map<FloorItems, Array<Dynamic>>> {
        var floorData:Map<Int, Map<FloorItems, Array<Dynamic>>> = [
			//1, ["enemy"=>[0,0], "item"=>[0,0]]; room index, map of entitys
		];

        var parsedData:FloorJSON = Json.parse(File.getContent(Paths.data(filePath, Json_File)));

        if (parsedData != null && parsedData.rooms != null) {
            for (room in parsedData.rooms) {
                var roomData:RoomData = new RoomData(room.id);
                if (room.enemies != null) roomData.enemies = _parse(room.enemies,"enemies");
                if (room.items != null) roomData.items = _parse(room.items,"items");

				var ENTITYS:Map<FloorItems, Array<Dynamic>> = [];
				ENTITYS.set(FloorItems.ENEMY, roomData.enemies);
				ENTITYS.set(FloorItems.ITEM, roomData.items);
				
                floorData.set(roomData.id, ENTITYS);
            }
        }

        return floorData;
    }

    private static function _parse(data:Array<Dynamic>, T:String):Array<Dynamic> {
		switch(T.toLowerCase()){
			case "enemies"
				var enemies:Array<EnemyData> = [];
				for (enemy in data) {
					enemies.push(new EnemyData(enemy.type, enemy.x, enemy.y));
				}
				return enemies;
			case "items":
				var items:Array<ItemData> = [];
				for (item in data) {
					items.push(new ItemData(item.type, item.x, item.y));
				}
				return items;
		}
		return null; // uh oh.h,.,.,.,.,.,
    }
}