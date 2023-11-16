package gfx;

import util.*;
import backend.*;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMatrix;
import gfx.*;
import shaders.FlxRuntimeShader;
import shaders.Shaders;
import flixel.util.FlxSort;

class DefaultSpriteGroup<T>(Class<T>): FlxTypedGroup<T> {
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