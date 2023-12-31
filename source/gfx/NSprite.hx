package gfx;

import flixel.FlxSprite;
import flash.display.BitmapData;
import flixel.graphics.*;
import flixel.system.FlxAssets.FlxGraphicAsset;

import flixel.math.FlxPoint;

class NSprite extends FlxSprite implements gfx.interfaces.InGFXobj
{
    static public final OFS:Float = 0.7333333;
    public var z:Float = 0;
	public var animOffsets:Map<String, Array<Dynamic>>;

    public var _offsetScale(default, set):FlxPoint = null;
    public function set__offsetScale(v:FlxPoint) {
        v.x= v.x*OFS;
        return null;
    }
    public dynamic function preUpdate(elapsed:Float) {}
    public dynamic function postUpdate(elapsed:Float) {}

    public var __graphic__(get,default):FlxGraphic;
    public function get___graphic__(){ return this.SimpleGraphicDefault; }

    public var SimpleGraphicDefault:FlxGraphicAsset;
    override function update(elapsed:Float) {
        preUpdate(elapsed);
        super.update(elapsed);
        postUpdate(elapsed);
    }
    public function new(x:Float = 0 ,y:Float = 0,?g:Null<FlxGraphicAsset>) {
        this.SimpleGraphicDefault = g;
        super(x,y,g);
        animOffsets = new Map<String, Array<Dynamic>>();

        //__graphic__= g != null ? g : new BitmapData(500,500,false,0xFFFFFFFF).fromImage("haxe/default-byte-logo.png");
    }
    public function addAnim(n:String = "d", p:String = "d", fps:Int = 24, loop:Bool = false){ this.animation.addByPrefix(n,p,fps,loop); }
    public function play(n:String = "d", force:Bool = false){ 
        this.animation.play(n,force); 

        var daOffset = animOffsets.get(n);
		if (animOffsets.exists(n)) offset.set(daOffset[0], daOffset[1]);
		else offset.set(0, 0);
    }
}