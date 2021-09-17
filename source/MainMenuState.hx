package;

#if desktop
import Discord.DiscordClient;
#end

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.plugin.FlxScrollingText;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import io.newgrounds.NG;
import lime.app.Application;
import lime.utils.Assets;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import openfl.Lib;

using StringTools;

class MainMenuState extends MusicBeatState
{
	
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	var menuBGs:FlxTypedGroup<FlxSprite>;
	//var configText:FlxText;
	//var configSelected:Int = 0;
	
	var optionShit:Array<String> = ['story mode', 'freeplay', "options", 'credits', "discord"];

	var magenta:FlxSprite;
	var blackbar:FlxSprite;
	var camFollow:FlxObject;

	var versionText:FlxText;
	var keyWarning:FlxText;
	var scrollTxt:FlxSprite;

	override function create()
	{

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		openfl.Lib.current.stage.frameRate = 144;

		if (!FlxG.sound.music.playing)
		{	
			FlxG.sound.playMusic("assets/music/klaskiiLoop.ogg", 0.75);
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/menuBG.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.18));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);
	
		magenta = new FlxSprite(-80).loadGraphic('assets/images/menuBGMagenta.png');
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.18;
		magenta.setGraphicSize(Std.int(magenta.width * 1.18));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		add(magenta);

		/*blackbar = new FlxSprite(-80).loadGraphic('assets/images/black_bar.png');
		blackbar.setGraphicSize(Std.int(blackbar.width * 0.69));
		blackbar.updateHitbox();
		blackbar.screenCenter();
		blackbar.x += 30;
		blackbar.y += 315;
		blackbar.visible = true;
		blackbar.antialiasing = true;
		add(blackbar);
		blackbar.scrollFactor.set();*/

		
		
		var tb:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/mainmenu/textthing.png');
		tb.scrollFactor.x = 0;
		tb.scrollFactor.y = 0;
		tb.setGraphicSize(Std.int(tb.width * 1));
		tb.updateHitbox();
		tb.screenCenter();
		tb.antialiasing = true;
		add(tb);	

		
		scrollTxt = new FlxSprite(0, 0);
		scrollTxt.frames = FlxAtlasFrames.fromSparrow('assets/images/mainmenu/backtxt.png', 'assets/images/mainmenu/backtxt.xml');
		scrollTxt.animation.addByPrefix("txt", "backtxt", 0, false);
		scrollTxt.animation.play("txt", true, false, curSelected);
		scrollTxt.antialiasing = true;
		scrollTxt.screenCenter();
		scrollTxt.y = 0;
		scrollTxt.scrollFactor.x = 0;
		scrollTxt.scrollFactor.y = 0;
		add(scrollTxt);
		
		
		var t1:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/mainmenu/triangles1.png');
		t1.scrollFactor.x = 0;
		t1.scrollFactor.y = 0;
		t1.setGraphicSize(Std.int(t1.width * 1));
		t1.updateHitbox();
		t1.screenCenter();
		t1.antialiasing = true;
		add(t1);

		var t2:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/mainmenu/triangles2.png');
		t2.scrollFactor.x = 0;
		t2.scrollFactor.y = 0;
		t2.setGraphicSize(Std.int(t2.width * 1));
		t2.updateHitbox();
		t2.screenCenter();
		t2.antialiasing = true;
		add(t2);

		var mf:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/mainmenu/menuframes.png');
		mf.scrollFactor.x = 0;
		mf.scrollFactor.y = 0;
		mf.setGraphicSize(Std.int(mf.width * 1));
		mf.updateHitbox();
		mf.screenCenter();
		mf.antialiasing = true;
		add(mf);

		var bt1:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/mainmenu/buttonthing2.png');
		bt1.scrollFactor.x = 0;
		bt1.scrollFactor.y = 0;
		bt1.setGraphicSize(Std.int(bt1.width * 1));
		bt1.updateHitbox();
		bt1.screenCenter();
		bt1.antialiasing = true;
		add(bt1);

		var bt2:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/mainmenu/buttonthing1.png');
		bt2.scrollFactor.x = 0;
		bt2.scrollFactor.y = 0;
		bt2.setGraphicSize(Std.int(bt2.width * 1));
		bt2.updateHitbox();
		bt2.screenCenter();
		bt2.antialiasing = true;
		add(bt2);
	
		var bt3:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/mainmenu/buttonthing3.png');
		bt3.scrollFactor.x = 0;
		bt3.scrollFactor.y = 0;
		bt3.setGraphicSize(Std.int(bt3.width * 1));
		bt3.updateHitbox();
		bt3.screenCenter();
		bt3.antialiasing = true;
		add(bt3);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = FlxAtlasFrames.fromSparrow('assets/images/FNF_main_menu_assets.png', 'assets/images/FNF_main_menu_assets.xml');
		var texBg = FlxAtlasFrames.fromSparrow('assets/images/b3_select_thingy.png', 'assets/images/b3_select_thingy.xml');
		var texMod = FlxAtlasFrames.fromSparrow('assets/images/FNF_mod_menu_assets.png', 'assets/images/FNF_mod_menu_assets.xml');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(15, 180 + (i * 50));

			if(optionShit[i] == "mod") {
				menuItem.frames = texMod;
			}
			else {
				menuItem.frames = tex;
			}
			
			menuItem.animation.addByIndices('idle', optionShit[i],[0],"", 24);
			menuItem.animation.addByIndices('selected', optionShit[i],[3],"", 24);
			menuItem.setGraphicSize(Std.int(menuItem.width * 0.7));
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
		}

		FlxG.camera.follow(camFollow, null, 0.004);

		
		
		versionText = new FlxText(5, FlxG.height - 21, 0, Assets.getText('assets/data/version.txt'), 16);
		versionText.scrollFactor.set();
		versionText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionText);

		keyWarning = new FlxText(5, FlxG.height - 21 + 16, 0, "If your controls aren't working, try pressing BACKSPACE to reset them.", 16);
		keyWarning.scrollFactor.set();
		keyWarning.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		keyWarning.alpha = 0;
		add(keyWarning);

		FlxTween.tween(versionText, {y: versionText.y - 16}, 0.75, {ease: FlxEase.quintOut, startDelay: 10});
		FlxTween.tween(keyWarning, {alpha: 1, y: keyWarning.y - 16}, 0.75, {ease: FlxEase.quintOut, startDelay: 10});

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();
		
		//Offset Stuff
		Config.reload();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
	
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
scrollTxt.x -= 3 * 60 / Lib.current.stage.frameRate;
if(scrollTxt.x < -1280) scrollTxt.x = 0;
		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
				changeItem(1);
			}

			if (FlxG.keys.justPressed.BACKSPACE)
			{
				KeyBinds.resetBinds();
				FlxG.switchState(new MainMenuState());
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}
			if (FlxG.keys.justPressed.Q)
			{
				trace(scrollTxt.getPosition());
			}
//scrollTxt.setPosition(FlxG.mouse.x, FlxG.mouse.y);
			if (controls.ACCEPT)
			{
			
				//Config.write(offsetValue, accuracyType, healthValue / 10.0, healthDrainValue / 10.0);
			
				if (optionShit[curSelected] == 'donate')
				{
					#if linux
					Sys.command('/usr/bin/xdg-open', ["https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game", "&"]);
					#else
					FlxG.openURL('https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game');
					#end
				}

				else if (optionShit[curSelected] == 'mod')
				{
					#if linux
					Sys.command('/usr/bin/xdg-open', ["https://gamebanana.com/gamefiles/13982", "&"]);
					#else
					FlxG.openURL('https://gamebanana.com/gamefiles/13982');
					#end
				}
				
				else
				{
					selectedSomethin = true;
					FlxG.sound.play('assets/sounds/confirmMenu' + TitleState.soundExt);
					
					var daChoice:String = optionShit[curSelected];
					
					switch (daChoice){
						case 'freeplay':
							FlxG.sound.music.stop();
						case 'options':
							FlxG.sound.music.stop();
					}

					FlxFlicker.flicker(magenta, 1.1, 0.15, false);

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
								//var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story mode':
										FlxG.switchState(new StoryMenuState());
										trace("Story Menu Selected");
									case 'freeplay':
										FreeplayState.startingSelection = 0;
										FlxG.switchState(new FreeplayState());
										trace("Freeplay Menu Selected");
									case 'options':
										FlxG.switchState(new ConfigMenu());
										trace("options time");
								}
							});
						}
					});
				}
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;
		//configSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
 		if (curSelected < 0)
			curSelected = menuItems.length - 1;
			
		scrollTxt.animation.play("txt", true, false, curSelected);
		/*if (configSelected > 3)
			configSelected = 0;
		if (configSelected < 0)
			configSelected = 3;*/

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}
