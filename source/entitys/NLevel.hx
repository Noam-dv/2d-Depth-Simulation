package entitys;

import flixel.FlxState;
import gfx.NSprite;
import backend.FloorFile.FloorItems;

class NLevel extends FlxState
{
	public var background:NSprite;
	public var forground:NSprite;

	public var fgSprites:Array<NSprite> = [];
	public function addSpr(spr:NSprite) 
	{
		add(spr);
	}
	public function addInfront(spr:NSprite) 
	{
		fgSprites.push(spr);
	}
}
