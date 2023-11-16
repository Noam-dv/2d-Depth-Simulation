package gfx;

import flixel.group.FlxGroup.FlxTypedGroup;

class DefaultSpriteGroup<T: flixel.FlxObject> extends FlxTypedGroup<T> {
    public var x:Float;
    public var y:Float;
    public var z:Float;
    public var width:Float;
    public var height:Float;
    public var flipX:Bool;

    public function new() {
        super();
    }
}
