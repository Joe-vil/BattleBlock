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
import StageData;
import FunkinLua;
import DialogueBoxPsych;
import openfl.utils.Assets as OpenFlAssets;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

#if sys
import sys.FileSystem;
#end

class MainMenuState extends MusicBeatState
{
	private var mosueoverbuttionsshit:Bool = true;

	var entersound:FlxSound;

	var bird:FlxSprite;
	var freeplay:FlxSprite;
	var story:FlxSprite;
	var settings:FlxSprite;

	override public function create()
	{
		if(FlxG.sound.music == null) {
			FlxG.sound.playMusic(Paths.music('funkMenu_test01'), 0);

			FlxG.sound.music.fadeIn(4, 0, 0.7);
		}
		
		var bg:BGSprite = new BGSprite('ui assets/menuBG_hatty_2', 0, 0);
		bg.antialiasing = true;
		bg.active = false;

		bird = new FlxSprite(-340.15, 12.5);
		bird.frames = Paths.getSparrowAtlas('ui assets/bird');
		bird.animation.addByPrefix('idle', 'menu whale idle', 24, true);
		bird.animation.play('idle');
		bird.antialiasing = true;

		freeplay = new FlxSprite(518, 738);
		freeplay.frames = Paths.getSparrowAtlas('ui assets/freeplay-box');
		freeplay.animation.addByPrefix('idle', 'freeplay box', 24, false);
		freeplay.animation.addByPrefix('1enter', 'box gold', 24, false);
		freeplay.animation.play('idle');
		freeplay.antialiasing = true;

		story = new FlxSprite(211, 755);
		story.frames = Paths.getSparrowAtlas('ui assets/storymenu-box');
		story.animation.addByPrefix('idle', 'story mode box', 24, false);
		story.animation.addByPrefix('2enter', 'mode box gold', 24, false);
		story.animation.play('idle');
		story.antialiasing = true;

		settings = new FlxSprite(794, 755);
		settings.frames = Paths.getSparrowAtlas('ui assets/settings-box');
		settings.animation.addByPrefix('idle', 'options box', 24, false);
		settings.animation.addByPrefix('3enter', 'box gold', 24, false);
		settings.animation.play('idle');
		settings.antialiasing = true;

		FlxTween.tween(freeplay, {x: 518, y: 332}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0.1});
		FlxTween.tween(story, {x: 211, y: 349}, 0.9, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0.1});
		FlxTween.tween(settings, {x: 794, y: 349}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0.1});
		FlxTween.tween(bird, {x: -58.2, y: 20.15}, 1, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0.5});

		add(bg);
		add(freeplay);
		add(story);
		add(settings);
		add(bird);

		super.create();
	}

	function enterfreeplay()
	{
		// entersound.play();
		FlxTween.tween(freeplay, {x: 518, y: -246.6}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		FlxTween.tween(story, {x: 211, y: -229.6}, 0.9, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		FlxTween.tween(settings, {x: 794, y: -229.6}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		FlxTween.tween(bird, {x: -340.15, y: 12.5}, 1, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0.5});
		new FlxTimer().start(0.5, function(tmr:FlxTimer)
			{
				MusicBeatState.switchState(new FreeplayState());
			});
	}

	function enterstory()
		{
			// entersound.play();
			FlxTween.tween(freeplay, {x: 518, y: -246.6}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
			FlxTween.tween(story, {x: 211, y: -229.6}, 0.9, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
			FlxTween.tween(settings, {x: 794, y: -229.6}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
			FlxTween.tween(bird, {x: -340.15, y: 12.5}, 1, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0.5});
			new FlxTimer().start(0.5, function(tmr:FlxTimer)
				{
					MusicBeatState.switchState(new StoryMenuNew());
				});
		}

		function entersettings()
			{
				// entersound.play();
				FlxTween.tween(freeplay, {x: 518, y: -246.6}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
				FlxTween.tween(story, {x: 211, y: -229.6}, 0.9, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
				FlxTween.tween(settings, {x: 794, y: -229.6}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
				FlxTween.tween(bird, {x: -340.15, y: 12.5}, 1, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0.5});
				new FlxTimer().start(0.5, function(tmr:FlxTimer)
					{
						MusicBeatState.switchState(new OptionsState());
					});
			}

			function entercredits()
				{
					// entersound.play();
					FlxTween.tween(freeplay, {x: 518, y: -246.6}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
					FlxTween.tween(story, {x: 211, y: -229.6}, 0.9, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
					FlxTween.tween(settings, {x: 794, y: -229.6}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
					FlxTween.tween(bird, {x: -340.15, y: 12.5}, 1, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0.5});
					new FlxTimer().start(0.5, function(tmr:FlxTimer)
						{
							MusicBeatState.switchState(new OptionsState());
						});
				}
			

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		//freeplay button
		if (FlxG.mouse.overlaps(freeplay))
		{
			freeplay.animation.play('1enter');
			if (FlxG.mouse.justPressed)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				enterfreeplay();
			}
		}
		else
		{
			freeplay.animation.play('idle');
		}

		//story button
		if (FlxG.mouse.overlaps(story))
		{
			story.animation.play('2enter');
			if (FlxG.mouse.justPressed)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				enterstory();
			}
		}
		else
		{
			story.animation.play('idle');
		}

		//settings button
		if (FlxG.mouse.overlaps(settings))
			{
				settings.animation.play('3enter');
				if (FlxG.mouse.justPressed)
				{
					FlxG.sound.play(Paths.sound('confirmMenu'));
					entersettings();
				}
			}
			else
			{
				settings.animation.play('idle');
			}

			if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

		FlxG.mouse.visible = true;

	}
}
