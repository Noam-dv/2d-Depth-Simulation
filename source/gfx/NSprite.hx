package gfx;

import flixel.FlxSprite;
import flash.display.BitmapData;
import flixel.graphics.*;

class NSprite extends FlxSprite implements gfx.interfaces.InGFXobj
{
    static public final OFS:Float = 0.7333333;



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
    public function new(x:Float,y:Float,?g:Null<FlxGraphicAsset>) {
        this.SimpleGraphicDefault = g;
        //__graphic__= g != null ? g : new BitmapData(500,500,false,0xFFFFFFFF).fromImage("haxe/default-byte-logo.png");
    }
    public function addAnim(n:String = "d", p:String = "d", fps:Int = 24, loop:Bool = false){ this.animation.addByPrefix(n,p,fps,loop); }
    public function play(n:String = "d", force:Bool = false){ this.animation.play(n,force); }
}