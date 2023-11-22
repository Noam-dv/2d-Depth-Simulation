package backend;

import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import backend.*;
import backend.FloorFile.*;

class Paths {
    public static var __default__:String = "assets/default.png";

    public static function data(key:String, T:AssetTypes = Json_File):Any {
        switch (T) {
            case AssetTypes.Json_File:

                trace(dataPath(key,"json"));
                return dataPath(key,"json");
        }
        return dataPath(key,"json");
    }
// Paths.hx
    public static function graphic(key:String, T:AssetTypes = Image):Any {
        switch (T) {
            case AssetTypes.SparrowV2:

                trace(img('atlases/' + key), xml('images/atlases/' + key));
                return FlxAtlasFrames.fromSparrow(img('atlases/' + key), xml('images/atlases/' + key));

            case AssetTypes.Image:

                return img(key);

            case AssetTypes.Xml:

                var xmlPath:String = xml("images/" + key);
                trace("Warning: XML path returned, but not used for FlxGraphic creation:", xmlPath);
                return new FlxSprite(); // or return new FlxGraphic(); depending on your needs

            default:

                return new FlxSprite(); 
        }
    }
    public static function img(key:String):Any {
        return 'assets/images/' + key + ".png";
    }
    
    public static function xml(key:String):Any {
        return 'assets/' + key + ".xml";
    }
    public static function dataPath(key:String, ext:String):String {
        return 'assets/data/' + key + "/" + ext;
    }
}
