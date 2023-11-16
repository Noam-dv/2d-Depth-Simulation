package;


import flixel.graphics.FlxGraphic;

import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;



class Main extends Sprite
{
	var winPrefs = {
		w: 1280,
		h: 1280,
		fps: 240,
		state: states.PlayState,
		save_prefix: 0,
		win_title: " byte "
	};

	public static function main()
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();
		setupGame();
	}


	private function setupGame()
	{
		addChild(new FlxGame(winPrefs.w, winPrefs.h, winPrefs.state, winPrefs.fps, winPrefs.fps));
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, crashHandler);
	}
	function crashHandler(e:UncaughtErrorEvent){ // inspired by "sqirra-rng"s crash handler
		var exceptionStack = CallStack.exceptionStack(true);
		if (!FileSystem.exists("./crashes/")) FileSystem.createDirectory("./crashes/");
		File.saveContent("./crash/" + "" + Std.string(Date.now()) + ".crash", exceptionStack);
		Application.current.window.alert("The game Has crashed!" + "\n" + exceptionStack, "crashed");		
		Sys.exit(1);
	}
}
