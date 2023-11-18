package entitys;

import backend.*;
import flixel.FlxG;
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

class Byte extends DefaultSpriteGroup<NSprite>
{
	public static var SCALE_MULTIPLIER:Float = 3.3333333 * 0.5;

	public var mouth:NSprite;
	public var chest:NSprite;
	public var legs:NSprite;

	public var originalByteScale:FlxPoint;
	public var camOffset:FlxPoint;

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
	public var curRoomHeight:Float = 0;
	public var yMoveFac:Float = 2;
	public var speedFactor:Float = 11.5;

	public function addForce(fx:Float, fy:Float)
	{
		accelerationX += fx;
		accelerationY += fy;
	}

	public function setForce(fx:Null<Float>, fy:Null<Float>)
	{
		accelerationX = fx != null ? fx : accelerationX;
		accelerationY += fy != null ? fy : accelerationY;
	}

	var maxHeights:Array<HeightThreshold> = [
		{xThreshold: -500, xEndThreshold: 580, height: 20},
		{xThreshold: 580, xEndThreshold: 10000, height: 50}
		//thresholds for maximum height
	];
	
	var minHeights:Array<HeightThreshold> = [
		{xThreshold: -500, xEndThreshold: -160, height: 55},
		{xThreshold: -160, xEndThreshold: 10000, height: 80}
		//thresholds for minimum height
	];

	public function getMaxHeight():Float {	
		for (i in 0...maxHeights.length) {
			var startThreshold = maxHeights[i].xThreshold;
			var endThreshold = maxHeights[i].xEndThreshold;
			var height = maxHeights[i].height;
	
			if (mouth.x > startThreshold && mouth.x < endThreshold) {
				return height; 
			}
		}
	
		return 40;
	}
	
	public function getMinHeight():Float {
		for (i in 0...minHeights.length) {
			var startThreshold = minHeights[i].xThreshold;
			var endThreshold = minHeights[i].xEndThreshold;
			var height = minHeights[i].height;
	
			if (mouth.x > startThreshold && mouth.x < endThreshold) {
				return height;
			}
		}
	
		return 10;
	}

	public function new(?base_height:Null<Float>, ?camOffset:Null<FlxPoint>)
	{
		super();

		graphics();

		camOffset = new FlxPoint(-300, 0);

		this.base_height = mouth.y;

		if (camOffset != null)
			this.camOffset = camOffset;
		if (base_height != null)
			this.base_height = base_height;
		originalByteScale = new FlxPoint(mouth.scale.x, mouth.scale.y);
	}

	public function graphics()
	{
		mouth = new NSprite();
		chest = new NSprite();
		legs = new NSprite();

		mouth.frames = Paths.graphic("byte-sketches", SparrowV2);
		mouth.addAnim("idle", "BYTEIDLEMOUTH", 24, true);
		mouth.addAnim("walk", "BYTEWALKMOUTH", 24, true);
		mouth.play("idle", true);
		mouth.z = 2;

		chest.frames = Paths.graphic("byte-sketches", SparrowV2);
		chest.addAnim("idle", "BYTEIDLEBODY", 24, true);
		chest.addAnim("walk", "BYTEWALKBODY", 24, true);
		chest.play("idle", true);
		chest.z = 1;

		legs.frames = Paths.graphic("byte-sketches", SparrowV2);
		legs.addAnim("idle", "BYTEIDLELEGS", 24, true);
		legs.addAnim("walk", "BYTEWALKLEGS", 24, true);
		legs.play("idle", true);
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

		forEach(function(t:NSprite)
		{
			t.scale.x *= SCALE_MULTIPLIER;
		});
	}

	public function layerByZ()
	{
		this.sort(Util.byZ, FlxSort.ASCENDING); // sort 3d layering
	}

	public function handleForce()
	{
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

	public override function update(dt:Float)
	{
		super.update(dt);
		curFrame++;
		if (curFrame % 50 == 0)
		{
			dsShader.setFloat("rx", FlxG.random.float(0.002, 0.02));
			dsShader.setFloat("ry", FlxG.random.float(0.0045, 0.095));
			dsShader.setFloat("iTime", dt);
		}
		handleInput(dt);
		handleForce();
		layerByZ();
		handleAnims();
	}

	private function adjustScaling()
	{
		forEach(function(byte:NSprite)
		{
			byte.scale.x = FlxMath.lerp(byte.scale.x, originalByteScale.x + (z * 0.04), FlxG.elapsed * 9.5);
			byte.scale.y = FlxMath.lerp(byte.scale.y, originalByteScale.x + (z * 0.04), FlxG.elapsed * 9.5);
		});
	}

	public function handleInput(elapsed:Float)
	{
		moveCalc(elapsed);
		calcDepth(elapsed);

		width = mouth.frameWidth;
		height = mouth.frameWidth;
	}

	function calcDepth(elapsed:Float)
	{
		if (FlxG.keys.pressed.W)
			curRoomHeight -= yMoveFac;
		if (FlxG.keys.pressed.S)
			curRoomHeight += yMoveFac;
		forEach(function(byte:NSprite)
		{
			byte.y = FlxMath.lerp(byte.y, base_height + curRoomHeight, elapsed * 9.5);
		});

		trace(getMinHeight());
		if (curRoomHeight > getMinHeight())
			curRoomHeight = getMinHeight();	
		if (curRoomHeight < -getMaxHeight())
			curRoomHeight = -getMaxHeight();

		this.z = curRoomHeight / 10;
		adjustScaling();
	}

	public function moveCalc(elapsed:Float)
	{
		var walkMult = 0.3;
		var runMult = 0.6;

		var _speed = (FlxG.keys.pressed.SHIFT ? runMult : walkMult) * (speedFactor + (z * 0.25));
		xSpeed = (FlxG.keys.pressed.A ? -acceleration : (FlxG.keys.pressed.D ? acceleration : 0)) * _speed;
		if (FlxG.keys.pressed.A)
			flipX = true;
		if (FlxG.keys.pressed.D)
			flipX = false;

		xSpeed *= friction;
		xSpeed = Math.min(Math.max(xSpeed, -maxSpeed * _speed), maxSpeed);

		forEach(function(byte:NSprite)
		{
			byte.flipX = flipX;
			forEach(function(byte:NSprite)
			{
				byte.x = FlxMath.lerp(byte.x, byte.x + xSpeed, elapsed * 9.5);
			});
		});
	}

	public function handleAnims()
	{
		forEach(function(bodyPart:NSprite)
		{
			if (xSpeed != 0 || FlxG.keys.pressed.W || FlxG.keys.pressed.S)
			{
				if (FlxG.keys.pressed.SHIFT)
					bodyPart.play("walk");
				else
					bodyPart.play("walk");
			}
			else
				bodyPart.play("idle");
		});
	}
}
