package gfx;

import flixel.FlxSprite;

class NSprite extends FlxSprite {
    final static public var OFS:Float = 0.7333333;
    public var _offsetScale(default, set):FlxPoint = null;
    public function set__offsetScale(v:FlxPoint) {
        v.x= v.x*OFS;
        return null;
    }
    public dynamic function preUpdate(elapsed:Float) {}
    public dynamic function postUpdate(elapsed:Float) {}
    override function update(elapsed:Float) {
        preUpdate(elapsed);
        super.update(elapsed);
        postUpdate(elapsed);
    }
    public function addAnim(n:String = "d", p:String = "d", fps:Int = 24, loop:Bool = false){ this.animation.addByPrefix(n,p,fps,loop); }
    public function play(n:String = "d", force:Bool = false){ this.animation.play(n,force); }
}