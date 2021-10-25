package;

import haxe.macro.Expr.Catch;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.system.System;

class NewMainMenu extends MusicBeatState
{
	var bgdots:FlxBackdrop;

	private var mosueoverbuttionsshit:Bool = true;

	var hoversound:FlxSound;
	var entersound:FlxSound;

	var whitebg:FlxSprite;
	var menubar:FlxSprite;
	var creds:FlxSprite;
	var zARDY:FlxSprite;
	var logo:FlxSprite;

	var freeplay:FlxSprite;
	var story:FlxSprite;

	var DRANGPN:FlxText;

	override public function create()
	{
       FlxG.sound.playMusic(Paths.music('kirby'));
		// hoversound = FlxG.sound.load(Paths.sound('hover'));
		// entersound = FlxG.sound.load(Paths.sound('enter'));

		whitebg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);

		freeplay = new FlxSprite(80, 356.8);
		freeplay.frames = Paths.getSparrowAtlas('ui assets/freeplay-box');
		freeplay.animation.addByPrefix('idle', 'freeplay box', 24, false);
		freeplay.animation.addByPrefix('enter', 'box gold', 24, false);
		freeplay.animation.play('idle');
		freeplay.antialiasing = true;

		story = new FlxSprite(80.05, 425);
		story.frames = Paths.getSparrowAtlas('ui assets/freeplay-box');
		story.animation.addByPrefix('idle', 'freeplay box', 24, false);
		story.animation.addByPrefix('enter', 'box gold', 24, false);
		story.animation.play('idle');
		story.antialiasing = true;

		DRANGPN = new FlxText(128, 100, 1000, "DRAGON GO LOOK AT THE ASSETS AND FIND THE .TXT FILE", 40);
		DRANGPN.color = FlxColor.BLACK;

		// FlxTween.tween(menubar, {x: -44, y: -47}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 8.5});
		// FlxTween.tween(logo, {x: 135.1, y: 41.3}, 0.9, {type: ONESHOT, ease: FlxEase.bounceOut, startDelay: 8.5});

		add(whitebg);

		add(freeplay);
		// add(story);

		add(DRANGPN);

		super.create();
	}

	function fadeout():Void
	{
		// FlxTween.tween(menubar, {x: -382, y: -47}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		// FlxTween.tween(logo, {x: 135.1, y: -305.9}, 0.9, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		// FlxTween.tween(zARDY, {x: 355.55, y: 728.35}, 0.9, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		FlxG.sound.music.fadeOut(2);
		entersound.play();
	}

	function playgame()
	{
		MusicBeatState.switchState(new FreeplayState());
	}

	function quit()
	{
		fadeout();
		FlxG.camera.fade(FlxColor.WHITE, 2, false, function()
		{
			System.exit(0);
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.T)
			{
				FlxG.camera.fade(FlxColor.WHITE, 1, false, function()
				{
					MusicBeatState.switchState(new TitleState());
				});
			}

		if (FlxG.mouse.overlaps(freeplay))
		{
			freeplay.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				try
				{
					MusicBeatState.switchState(new MainMenuState());
				}
			}
		}
		else
		{
			freeplay.animation.play('idle');
		}

		if (FlxG.mouse.overlaps(story))
		{
			story.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				MusicBeatState.switchState(new MainMenuState());
			}
		}
		else
		{
			story.animation.play('idle');
		}
	}
}
