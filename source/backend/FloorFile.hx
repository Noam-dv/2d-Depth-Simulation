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

        var content:String = File.getContent(filePath);
        var parsedData:FloorJSON = Json.parse(Path.data(content, Json_File));

        if (parsedData != null && parsedData.rooms != null) {
            for (room in parsedData.rooms) {
                var roomData:RoomData = new RoomData(room.id);

                if (room.enemies != null)
                    roomData.enemies = parseEnemies(room.enemies);
                if (room.items != null)
                    roomData.items = parseItems(room.items);

                floorData.set(roomData.id, roomDataToMap(roomData));
            }
        }

        return floorData;
    }

    private static function parseEnemies(data:Array<Dynamic>):Array<EnemyData> {
        var enemies:Array<EnemyData> = [];
        for (enemy in data) {
            enemies.push(new EnemyData(enemy.type, enemy.x, enemy.y));
        }
        return enemies;
    }

    private static function parseItems(data:Array<Dynamic>):Array<ItemData> {
        var items:Array<ItemData> = [];
        for (item in data) {
            items.push(new ItemData(item.type, item.x, item.y));
        }
        return items;
    }

    private static function roomDataToMap(roomData:RoomData):Map<FloorItems, Array<Dynamic>> {
        var map:Map<FloorItems, Array<Dynamic>> = [];
        map.set(FloorItems.ENEMY, roomData.enemies);
        map.set(FloorItems.ITEM, roomData.items);
        return map;
    }
}