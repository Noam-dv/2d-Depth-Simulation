package entitys;

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
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class Byte extends DefaultSpriteGroup<NSprite> {
    public var mouth:NSprite;
    public var chest:NSprite;
    public var legs:NSprite;

    public var originalByteScale:FlxPoint;

    var dsShader:FlxRuntimeShader;
    var curFrame:Int = 0;

    var xSpeed:Float = 0;
    var acceleration:Float = 4;
    var friction:Float = 0.9;
    var maxSpeed:Float = 60;

    var velocityX:Float = 0;
    var velocityY:Float = 0;
    var accelerationX:Float = 0;
    var accelerationY:Float = 0;
    var damping:Float = 0.6;


    public var base_height:Float;
    public function addForce(fx:Float, fy:Float) {
        accelerationX += fx;
        accelerationY += fy;
    }

    public function new(?base_height:Null<Float>) {
        super();

        mouth = new NSprite();
        chest = new NSprite();
        legs = new NSprite();

        mouth.frames = Paths.graphic("BYTE", SparrowV2);
        mouth.addAnim("mouth", "boc", 24, true);
        mouth.play("mouth", true);
        mouth.z = 2;

        chest.frames = Paths.graphic("BYTE", SparrowV2);
        chest.addAnim("mouth", "BOX", 24, true);
        chest.play("mouth", true);
        chest.z = 1;

        legs.frames = Paths.graphic("BYTE", SparrowV2);
        legs.addAnim("mouth", "legs", 24, true);
        legs.play("mouth", true);
        legs.z = 0;

        add(mouth);
        add(legs);
        add(chest);

        mouth.screenCenter();
        legs.screenCenter();
        chest.screenCenter();

        dsShader = Shaders.downscale();
        dsShader.setFloat("rx", 0.01);
        dsShader.setFloat("ry", 0.05);

        mouth.shader = dsShader;
        this.base_height = mouth.y;

        if(base_height != null) this.base_height = base_height;
        originalByteScale = new FlxPoint(mouth.scale.x, mouth.scale.y);
    }


    public function layerByZ() {
        this.sort(Util.byZ, FlxSort.ASCENDING); // sort 3d layering
    }

    public function handleForce() {
        velocityX += accelerationX;
        velocityY += accelerationY;

        velocityX *= damping;
        velocityY *= damping;

        forEach(function(byte:NSprite) {
            byte.x += velocityX;
            byte.y += velocityY;
        });

        accelerationX = 0;
        accelerationY = 0;
    }

    public override function update(dt:Float) {
        super.update(dt);
        curFrame++;
        if (curFrame % 50 == 0) {
            dsShader.setFloat("rx", FlxG.random.float(0.002, 0.02));
            dsShader.setFloat("ry", FlxG.random.float(0.0045, 0.095));
            dsShader.setFloat("iTime", dt);
        }
        handleInput(dt);
        handleForce();
        layerByZ();
    }

    
    var floor_height:Float = 0;
    var maxVertScale:Float = 0.5; 
    var yMoveFac:Float = 5;
    var speedFactor:Float = 1; 
    var curRoomHeight:Float = 0;
    
    private function adjustScaling() {
        forEach(function(byte:NSprite) {
            byte.scale.x = FlxMath.lerp(byte.scale.x, originalByteScale.x + (z * 0.04), FlxG.elapsed * 5);
            byte.scale.y = FlxMath.lerp(byte.scale.y, originalByteScale.x + (z * 0.04), FlxG.elapsed * 5);
        });
    }
    
    public function handleInput(elapsed:Float) {
        moveCalc(elapsed);
        calcDepth(elapsed);
        floor_height = y;
    
        width = mouth.frameWidth;
        height = mouth.frameWidth;
    }
    function calcDepth(elapsed:Float){
        if(FlxG.keys.pressed.W) curRoomHeight -= yMoveFac;
        if(FlxG.keys.pressed.S) curRoomHeight += yMoveFac;
        forEach(function(byte:NSprite) {
            byte.y = FlxMath.lerp(byte.y, base_height + curRoomHeight, elapsed*5);
        });
        
        if(curRoomHeight > 40) curRoomHeight = 40;
        if(curRoomHeight < -40) curRoomHeight = -40;

        this.z = curRoomHeight / 10; 
        trace(z);
        adjustScaling();
    }
    
    public function moveCalc(elapsed:Float){
        xSpeed = (FlxG.keys.pressed.A ? -acceleration : (FlxG.keys.pressed.D ? acceleration : 0)) * speedFactor;
        flipX = (xSpeed < 0);
        xSpeed *= friction;
        xSpeed = Math.min(Math.max(xSpeed, -maxSpeed * speedFactor), maxSpeed * speedFactor);        
    
        forEach(function(byte:NSprite) {
            byte.flipX = flipX;
            forEach(function(byte:NSprite) {
                byte.x = FlxMath.lerp(byte.x, byte.x + xSpeed, elapsed*5);
            });
            
        });
    }
    
}