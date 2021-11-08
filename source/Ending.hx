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

class Ending extends MusicBeatState
{

	override public function create()
	{
		FlxG.sound.music.fadeOut(0.01);
        startVideo('hatty');
        new FlxTimer().start(32, gobackyafool);
		super.create();
	}

    function gobackyafool(timer:FlxTimer):Void
        {
            FlxG.sound.music.fadeIn(1, 0, 0.7);
            MusicBeatState.switchState(new MainMenuState());
        }

    public function startVideo(name:String):Void {
		#if VIDEOS_ALLOWED
		var foundFile:Bool = false;
		var fileName:String = #if MODS_ALLOWED Paths.modFolders('videos/' + name + '.' + Paths.VIDEO_EXT); #else ''; #end
		#if sys
		if(FileSystem.exists(fileName)) {
			foundFile = true;
		}
		#end

		if(!foundFile) {
			fileName = Paths.video(name);
			#if sys
			if(FileSystem.exists(fileName)) {
			#else
			if(OpenFlAssets.exists(fileName)) {
			#end
				foundFile = true;
			}
		}

		if(foundFile) {
			var bg = new FlxSprite(-FlxG.width, -FlxG.height).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
			bg.scrollFactor.set();
			add(bg);

			(new FlxVideo(fileName)).finishCallback = function() 
            {

            }
			return;

		} else {
			FlxG.log.warn('Couldnt find video file: ' + fileName);
		}
		#end
	}
}
