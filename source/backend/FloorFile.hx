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
class FloorFile {
    public static function loadFloorFromFile(filePath:String):Map<Int, Map<FloorItems, Array<Dynamic>>> {
        var floorData:Map<Int, Map<FloorItems, Array<Dynamic>>> = new Map<Int, Map<FloorItems, Array<Dynamic>>>();

        var fileContent:String = File.getContent(Paths.data("test", Json_File));
        var parsedDynamic:Dynamic = Json.parse(fileContent);

        var jsonData:FloorJSON = new FloorJSON();
        jsonData.rooms = [];

        if (parsedDynamic != null && Reflect.hasField(parsedDynamic, "rooms")) {
            var rooms:Array<Dynamic> = Reflect.field(parsedDynamic, "rooms");

            for (room in rooms) {
                var roomData:RoomData = new RoomData(room.id);

                if (Reflect.hasField(room, "enemies")) {
                    var enemies:Array<Dynamic> = Reflect.field(room, "enemies");
                    for (enemy in enemies) {
                        var enemyData:EnemyData = new EnemyData(enemy.type, enemy.x, enemy.y);
                        roomData.enemies.push(enemyData);
                    }
                }

                if (Reflect.hasField(room, "items")) {
                    var items:Array<Dynamic> = Reflect.field(room, "items");
                    for (item in items) {
                        var itemData:ItemData = new ItemData(item.type, item.x, item.y);
                        roomData.items.push(itemData);
                    }
                }

                jsonData.rooms.push(roomData);
                floorData.set(roomData.id, roomDataToMap(roomData));
            }
        }

        return floorData;
    }

    private static function roomDataToMap(roomData:RoomData):Map<FloorItems, Array<Dynamic>> {
        var map:Map<FloorItems, Array<Dynamic>> = new Map<FloorItems, Array<Dynamic>>();
        map.set(FloorItems.ENEMY, roomData.enemies);
        map.set(FloorItems.ITEM, roomData.items);
        return map;
    }
}
