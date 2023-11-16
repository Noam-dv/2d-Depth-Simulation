package states;

import backend.*;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMatrix;
import gfx.*;
import shaders.FlxRuntimeShader;
import shaders.Shaders;

class PlayState extends FlxState
{
	public var byte:Byte;

	override public function create()
	{
		super.create();

		byte = new Byte();
		add(byte);

		FlxG.camera.bgColor = flixel.util.FlxColor.WHITE;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}

class Byte extends FlxTypedGroup<NSprite>
{
	public var mouth:NSprite;
	public var chest:NSprite;
	public var legs:NSprite;

	public var speed:Float = 0.9;

	var dsShader:FlxRuntimeShader;
	var curFrame:Int = 0;

	var xSpeed:Float = 0;
    var acceleration:Float = 7;
    var friction:Float = 0.9;
    var maxSpeed:Float = 60;

	// physics simulation
	var velocityX:Float = 0;
	var velocityY:Float = 0;
	var accelerationX:Float = 0;
	var accelerationY:Float = 0;
	var damping:Float = 0.9; //damping factor for smoothness
	public function addForce(fx:Float, fy:Float) {
        accelerationX += fx;
        accelerationY += fy;
    }

    public function handleInput() {
        xSpeed = 0;

        if (FlxG.keys.pressed.A) {
            xSpeed -= acceleration;
        } else if (FlxG.keys.pressed.D) {
            xSpeed += acceleration;
        }

        xSpeed *= friction;

        if (xSpeed > maxSpeed) {
            xSpeed = maxSpeed;
        } else if (xSpeed < -maxSpeed) {
            xSpeed = -maxSpeed;
        }
		forEach(function(byte:NSprite)
		{
			byte.x += xSpeed;
		});
    }

	public function new()
	{
		super();

		mouth = new NSprite();
		chest = new NSprite();
		legs = new NSprite();

		mouth.frames = Paths.graphic("BYTE", SparrowV2);
		mouth.addAnim("mouth", "boc", 24, true);
		mouth.play("mouth", true);

		chest.frames = Paths.graphic("BYTE", SparrowV2);
		chest.addAnim("mouth", "BOX", 24, true);
		chest.play("mouth", true);

		legs.frames = Paths.graphic("BYTE", SparrowV2);
		legs.addAnim("mouth", "legs", 24, true);
		legs.play("mouth", true);

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

	override function update(dt:Float)
	{
		super.update(dt);
		curFrame++;
		handleInput();
		if (curFrame % 7 == 0)
		{
			dsShader.setFloat("rx", FlxG.random.float(0.002, 0.02));
			dsShader.setFloat("ry", FlxG.random.float(0.0045, 0.055));
			dsShader.setFloat("iTime", dt);
		}


		handleForce();
	}
	public function handleForce(){
		velocityX += accelerationX;
        velocityY += accelerationY;

		velocityX *= damping;
        velocityY *= damping;

		forEach(function(byte:NSprite)
		{
			byte.x += velocityX;
			byte.y += velocityY;
		});

		accelerationX = 0;
        accelerationY = 0;
	}
}
