#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.4.1'; //This is also used for Discord RPC
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	var menuItemsSelected:FlxTypedGroup<FlxSprite>;


	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'options', 'music'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var dadui:FlxSprite;
	var dadsaw:FlxSprite;
	var dadlogo:FlxSprite;
	var player:FlxSprite;

	var tweenArray:Array<FlxTween> = [];
	var tweenArray2:Array<FlxTween> = [];


	public static var finishedFunnyMove:Bool = false;

	override function create()
	{

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('The_Menu_Thing'));
		}


		player = new FlxSprite(700, 0).loadGraphic(Paths.image('ui assets/kidfunny'));
		player.angularDrag = 50;
		player.maxAngular = 600;
		trace(player, "Player added!");


		persistentUpdate = persistentDraw = true;

		var dadnme:FlxSprite = new FlxSprite(-150, -350);
		dadnme.frames = Paths.getSparrowAtlas('ui assets/cloudspurp');
		dadnme.animation.addByPrefix('idle', 'clouds', 24);
		dadnme.animation.play('idle');
		dadnme.antialiasing = true;
		add(dadnme);

		var dadnme2:FlxSprite = new FlxSprite(180, -180);
		dadnme2.frames = Paths.getSparrowAtlas('ui assets/menu-bf');
		dadnme2.animation.addByPrefix('idle', 'menubf', 24);
		dadnme2.animation.play('idle');
		dadnme2.antialiasing = true;
		add(dadnme2);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('ui assets/Bjeff'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.10;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		dadsaw = new FlxSprite(0).loadGraphic(Paths.image('ui assets/dadsaw'));
		dadsaw.scrollFactor.x = 0;
		dadsaw.scrollFactor.y = 0;
		dadsaw.updateHitbox();
		dadsaw.screenCenter();
		dadsaw.visible = true;
		dadsaw.antialiasing = true;	
		add(dadsaw);

		dadui = new FlxSprite(0).loadGraphic(Paths.image('ui assets/DADmenu'));
		dadui.scrollFactor.x = 0;
		dadui.scrollFactor.y = 0;
		dadui.updateHitbox();
		dadui.screenCenter();
		dadui.visible = true;
		dadui.antialiasing = true;	
		add(dadui);
		
		dadlogo = new FlxSprite(0).loadGraphic(Paths.image('ui assets/DADlogo'));
		dadlogo.scrollFactor.x = 0;
		dadlogo.scrollFactor.y = 0;
		dadlogo.updateHitbox();
		dadlogo.screenCenter();
		dadlogo.visible = true;
		dadlogo.antialiasing = true;	
		add(dadlogo);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);
		menuItemsSelected = new FlxTypedGroup<FlxSprite>();
		add(menuItemsSelected);
		

		add(player);

		for (i in 0...optionShit.length)
		{


			var menuItem:FlxSprite = new FlxSprite(60, (i * 90) + 315).loadGraphic(Paths.image('ui assets/lolurbad' + i));
			menuItem.ID = i;
			// menuItem.screenCenter(X);
			menuItems.add(menuItem);
			//menuItem.scale.set(1, 0.65);
			menuItem.scrollFactor.set();
			menuItem.updateHitbox();
			menuItem.antialiasing = true;
			var menuItemSelected:FlxSprite = new FlxSprite(60, 0 + (i * 90)).loadGraphic(Paths.image('ui assets/lolurbadsel' + i));
			menuItemSelected.ID = i;
			// menuItemSelected.screenCenter(X);
			menuItemsSelected.add(menuItemSelected);
			//menuItemSelected.scale.set(1, 0.65);
			menuItemSelected.scrollFactor.set();
			menuItemSelected.updateHitbox();
			menuItemSelected.antialiasing = true;
			menuItemSelected.visible = false;


		}

		firstStart = false;

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));


		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{

		if (FlxG.keys.pressed.RIGHT)
			{
				player.x += 2;
				player.angularAcceleration = 50;
			}
		else
			{
				player.angularAcceleration = 0;
			}
	
		if (FlxG.keys.pressed.LEFT)
			{
				player.x -= 2;
				player.angularAcceleration = 50;
			}
		else
			{
				player.angularAcceleration = 0;
			}

		if (FlxG.keys.pressed.W)
			{
				// FlxG.switchState(new Hehestate());
			}
	
		// if (FlxG.keys.pressed.ALT)
		// 	{
		// 		player.angularAcceleration = 100;
		// 	}
		// else
		// 	{
		// 		player.angularAcceleration = 0;
		// 	}



		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}
			

			if (FlxG.keys.pressed.ENTER)
			{
				if (optionShit[curSelected] == 'donate')
					{
						CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
					}
					else
					{
						selectedSomethin = true;
						FlxG.sound.play(Paths.sound('confirmMenu'));
	
						if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);
	
						menuItems.forEach(function(spr:FlxSprite)
						{
							if (curSelected != spr.ID)
							{
								FlxTween.tween(spr, {alpha: 0}, 0.4, {
									ease: FlxEase.quadOut,
									onComplete: function(twn:FlxTween)
									{
										spr.kill();
									}
								});
							}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];
	
								switch (daChoice)
								{
									case 'story mode':
										MusicBeatState.switchState(new StoryMenuState());
										trace("Story Menu Selected");
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
										trace("Freeplay Menu Selected");
									case 'options':
										MusicBeatState.switchState(new OptionsState());
									case 'music':
										MusicBeatState.switchState(new CreditsState());
										trace("music Menu Selected");
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.justPressed.SEVEN)
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItemsSelected.forEach(function(spr:FlxSprite)
		{
			spr.setPosition(menuItems.members[spr.ID].x, menuItems.members[spr.ID].y);
		});
	}
	function changeItem(huh:Int = 0)
		{
			curSelected += huh;
	
			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			if (spr.ID == curSelected) {
				tweenArray[menuItems.members.indexOf(spr)] = FlxTween.tween(spr, {x: (FlxG.width) - 1100}, 0.2, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						if (spr.ID != curSelected)
						{
							spr.x = FlxG.width - 1220;
						}
					} 
				});
					
			} else {
				if (tweenArray[menuItems.members.indexOf(spr)] != null) {
					tweenArray[menuItems.members.indexOf(spr)].cancel();
				}
				if (tweenArray2[menuItems.members.indexOf(spr)] != null) {
					tweenArray2[menuItems.members.indexOf(spr)].cancel();
				}
				tweenArray2[menuItems.members.indexOf(spr)] = FlxTween.tween(spr, {x: FlxG.width - 1220}, 0.2, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						if (spr.ID != curSelected)
						{
							spr.x = FlxG.width - 1220;
						}
					} 
				});
				//spr.x = FlxG.width - 40;
			}
			/*spr.animation.play('idle');
	
			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}
			*/
			spr.updateHitbox();
		});
	}
}
	