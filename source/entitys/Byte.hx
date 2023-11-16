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

class Byte extends DefaultSpriteGroup<NSprite> {
    public var mouth:NSprite;
    public var chest:NSprite;
    public var legs:NSprite;

    public var speed:Float = 0.9;

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

    public var x:Float;
    public var y:Float;
    public var z:Float;
    public var width:Float;
    public var height:Float;
    public var flipX:Bool;

    public function addForce(fx:Float, fy:Float) {
        accelerationX += fx;
        accelerationY += fy;
    }

    public function new() {
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
    }

    public override function update(dt:Float) {
        super.update(dt);
        curFrame++;
        handleInput();
        if (curFrame % 50 == 0) {
            dsShader.setFloat("rx", FlxG.random.float(0.002, 0.02));
            dsShader.setFloat("ry", FlxG.random.float(0.0045, 0.095));
            dsShader.setFloat("iTime", dt);
        }
        handleForce();
        layerByZ();
        adjustScaling();
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

    private function adjustScaling() {
        forEach(function(byte:NSprite) {
            var scaleRatio:Float = 1.0 + byte.z * 0.1;
            byte.scale.set(scaleRatio, scaleRatio);
        });
    }
    

    var platformHeight:Float = 0; 

    public function handleInput() {
        xSpeed = 0;
        var verticalMoveFactor:Float = 0.1;

        if (FlxG.keys.pressed.A) {
            xSpeed -= acceleration;
            flipX = true;
        } else if (FlxG.keys.pressed.D) {
            xSpeed += acceleration;
            flipX = false;
        }

        xSpeed *= friction;

        if (xSpeed > maxSpeed) {
            xSpeed = maxSpeed;
        } else if (xSpeed < -maxSpeed) {
            xSpeed = -maxSpeed;
        }
        var prevY:Float = y; 

        forEach(function(byte:NSprite) {
            byte.flipX = flipX;
            byte.x += xSpeed;
        });

        y = prevY + ((FlxG.keys.pressed.W) ? -verticalMoveFactor : (FlxG.keys.pressed.S) ? verticalMoveFactor : 0);
        z = platformHeight - y; 
        platformHeight = y;

        width = mouth.frameWidth;
        height = mouth.frameWidth;
    }

}