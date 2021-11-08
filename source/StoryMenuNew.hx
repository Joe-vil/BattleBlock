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

class StoryMenuNew extends MusicBeatState
{
	private var mosueoverbuttionsshit:Bool = true;

	var entersound:FlxSound;

	var bird:FlxSprite;
	var freeplay:FlxSprite;
	var story:FlxSprite;
	var settings:FlxSprite;
	var hand:BGSprite;

	var curDifficulty:Int = 1;

	override public function create()
	{
		if(FlxG.sound.music == null) {
			FlxG.sound.playMusic(Paths.music('funkMenu_test01'), 0);

			FlxG.sound.music.fadeIn(4, 0, 0.7);
		}

		var bg:BGSprite = new BGSprite('ui assets/storymenubg', -70.9, -92.25);
		bg.antialiasing = true;
		bg.active = false;

		hand = new BGSprite('ui assets/handssssss', 0, 0);
		hand.antialiasing = true;
		hand.active = false;
		hand.alpha = 0;

		story = new FlxSprite(788.1, 92.85);
		story.frames = Paths.getSparrowAtlas('ui assets/storybutt');
		story.animation.addByPrefix('idle', 'Baaaaaaaa', 24, false);
		story.animation.addByPrefix('enter', 'aaaaaaaaa2', 24, false);
		story.animation.play('idle');
		story.antialiasing = true;

		FlxG.mouse.load(hand.pixels);

		add(bg);
		add(story);

		super.create();
	}

	function enterfreeplay()
	{
			PlayState.storyPlaylist = ["Strings", "Anarchy"];
			PlayState.isStoryMode = true;
			PlayState.seenCutscene = false;

			var diffic = CoolUtil.difficultyStuff[curDifficulty][1];

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.storyWeek = 1;
			PlayState.campaignScore = 0;
			PlayState.campaignMisses = 0;
			new FlxTimer().start(0.5, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState());
				FlxG.sound.music.volume = 0;
				FreeplayState.destroyFreeplayVocals();
				FlxG.mouse.unload();
			});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		//story button
		if (FlxG.mouse.overlaps(story))
		{
			story.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				enterfreeplay();
			}
		}
		else
		{
			story.animation.play('idle');
		}

		if (controls.BACK)
		{
			FlxG.mouse.unload();
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		FlxG.mouse.visible = true;

	}
}

