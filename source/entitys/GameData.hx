package entitys;

import haxe.Json;
import sys.io.File;

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
class FloorJSON {
    public var rooms:Array<RoomData>;

    public function new() {
        rooms = [];
    }
}

class RoomData {
    public var id:Int;
    public var enemies:Array<EnemyData>;
    public var items:Array<ItemData>;

    public function new(id:Int) {
        this.id = id;
        enemies = [];
        items = [];
    }
}

class EnemyData {
    public var type:String;
    public var x:Int;
    public var y:Int;

    public function new(type:String, x:Int, y:Int) {
        this.type = type;
        this.x = x;
        this.y = y;
    }
}

class ItemData {
    public var type:String;
    public var x:Int;
    public var y:Int;

    public function new(type:String, x:Int, y:Int) {
        this.type = type;
        this.x = x;
        this.y = y;
    }
}
