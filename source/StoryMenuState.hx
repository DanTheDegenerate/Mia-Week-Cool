package;

#if desktop
import Discord.DiscordClient;
#end

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;

using StringTools;

class StoryMenuState extends MusicBeatState
{
	var scoreText:FlxText;

	public static var weekData:Array<Dynamic>;
	var curDifficulty:Int = 1;

	public static var weekUnlocked:Array<Bool> = [true, true, true, true, true, true, true, true, true, true, true, true, true, true];

	public static var weekCharacters:Array<Dynamic>;

	public static var weekNames:Array<String>;

	var txtWeekTitle:FlxText;

	var curWeek:Int = 0;
	var weekThing:MenuItem;
	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;
	var coolerArrows:FlxSprite;
	var grpLocks:FlxTypedGroup<FlxSprite>;

	var ui_tex:FlxAtlasFrames;
	var bd:FlxSprite;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var diffGlow:FlxSprite;
	override function create()
	{

		openfl.Lib.current.stage.frameRate = 144;
	
		var bgg:FlxSprite = new FlxSprite( -56, -26).loadGraphic("assets/images/menu/bg.png");
		FlxTween.tween(bgg, {x:68, y:61}, 2, {type:LOOPING});
		weekData = [
			['Tutorial'],
			['Bopeebo', 'Fresh', 'Dadbattle'],
			['Spookeez', 'South', 'Not A Monster'],
			['Pico', 'Philly', "Blammed", 'School'],
			['Satin-Panties', "High", "Milf", "Milkies"],
			['Cocoa', 'Eggnog', 'Winter-Horrorland'],
			['Senpai', 'Roses', 'Thorns'],
			['Diva', "Revolution", "Mania"]
		];
		
		weekCharacters = [
			['dad', 'bf', 'gf'],
			['dad', 'bf', 'gf'],
			['spooky', 'bf', 'gf'],
			['pico', 'bf', 'gf'],
			['mom', 'bf', 'gf'],
			['parents-christmas', 'bf', 'gf'],
			['senpai', 'bf', 'gf'],
			['dad', 'bf', 'gf']
		];
	
		weekNames = CoolUtil.coolTextFile("assets/data/weekNames.txt");
	
		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic("assets/music/freakyMenu.ogg", 0.75);
		}
		bd = new FlxSprite(0, 0);
		bd.frames = FlxAtlasFrames.fromSparrow('assets/images/menu/backdrop.png', 'assets/images/menu/backdrop.xml');
		bd.animation.addByIndices("bd", "bd", [0, 0, 1, 2, 3, 4, 5, 6],"",0);
		bd.animation.play("bd", true, false, 0);
		add(bd);
		add(bgg);
		persistentUpdate = persistentDraw = true;
		var yellowBG:FlxSprite = new FlxSprite();
		scoreText = new FlxText(660, 10, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32);

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat("assets/fonts/vcr.ttf", 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		ui_tex = FlxAtlasFrames.fromSparrow('assets/images/campaign_menu_UI_assets.png', 'assets/images/campaign_menu_UI_assets.xml');
		

		grpWeekText = new FlxTypedGroup<MenuItem>();

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		add(blackBarThingie);

		var fg:FlxSprite = new FlxSprite().loadGraphic("assets/images/menu/blackshit.png");
		add(fg);
		var tl:FlxSprite = new FlxSprite().loadGraphic("assets/images/menu/tracklist.png");
		add(tl);
		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		trace("Line 70");

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		for (i in 0...weekData.length)
		{
			weekThing = new MenuItem(130, yellowBG.y + yellowBG.height + 10, i);
			weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			grpWeekText.add(weekThing);

			weekThing.scale.x = weekThing.scale.y = 1;
			weekThing.antialiasing = true;
			// weekThing.updateHitbox();

			// Needs an offset thingie
			if (!weekUnlocked[i])
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = true;
				grpLocks.add(lock);
			}
		}
		trace("Line 96");

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		trace("Line 124");

		leftArrow = new FlxSprite(grpWeekText.members[0].x + grpWeekText.members[0].width + 10, grpWeekText.members[0].y + 10);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		difficultySelectors.add(leftArrow);

		sprDifficulty = new FlxSprite(0, 0);
		diffGlow = new FlxSprite(0, 0).loadGraphic("assets/images/menu/diffglow.png");
		diffGlow.blend = "add";
		add(diffGlow);
		sprDifficulty.frames = FlxAtlasFrames.fromSparrow("assets/images/menu/diff.png","assets/images/menu/diff.xml");
		sprDifficulty.animation.addByIndices('easy', 'diff',[0],"");
		sprDifficulty.animation.addByIndices('normal', 'diff',[1],"");
		sprDifficulty.animation.addByIndices('hard', 'diff',[2],"");
		sprDifficulty.animation.addByIndices('getreal', 'diff',[3],"");
		sprDifficulty.animation.play('easy');
		changeDifficulty();

		difficultySelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(sprDifficulty.x + sprDifficulty.width + 50, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		difficultySelectors.add(rightArrow);
		
		leftArrow.angle = 90;
		rightArrow.angle = 90;
		trace("Line 150");

		add(grpWeekCharacters);

		txtTracklist = new FlxText(FlxG.width * 0.05, yellowBG.x + yellowBG.height + 100, 336, "Tracks", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFFe55777;
		
		add(grpWeekText);
		add(txtTracklist);
		// add(rankText);
		add(scoreText);
		add(txtWeekTitle);
		coolerArrows = new FlxSprite(227.45, 180).loadGraphic('assets/images/menu/coolerarrows.png');
		coolerArrows.antialiasing = true;
		add(coolerArrows);
		updateText();

		trace("Line 165");

		super.create();
		changeWeek();
	}

	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		scoreText.text = "WEEK SCORE:" + lerpScore;

		txtWeekTitle.text = weekNames[curWeek].toUpperCase();
		txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		// FlxG.watch.addQuick('font', scoreText.font);

		difficultySelectors.visible = weekUnlocked[curWeek];
		switch(curDifficulty){
			case 0:
				diffGlow.color = 0xFF00FF00;
			case 1:
				diffGlow.color = 0xFFFFFF00;
			case 2:
				diffGlow.color = 0xFFFF0000;
			case 3:
				diffGlow.color = 0xFFFF00FF;
		}
		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
		});

		if (!movedBack)
		{
			if (!selectedWeek)
			{
				if (controls.UP_P)
				{
					changeWeek(-1);
				}

				if (controls.DOWN_P)
				{
					changeWeek(1);
				}

				if (controls.RIGHT)
					rightArrow.animation.play('press')
				else
					rightArrow.animation.play('idle');

				if (controls.LEFT)
					leftArrow.animation.play('press');
				else
					leftArrow.animation.play('idle');

				if (controls.RIGHT_P)
					changeDifficulty(1);
				if (controls.LEFT_P)
					changeDifficulty(-1);
			}

			if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play('assets/sounds/cancelMenu' + TitleState.soundExt);
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (weekUnlocked[curWeek])
		{
			if (stopspamming == false)
			{
				FlxG.sound.play('assets/sounds/confirmMenu' + TitleState.soundExt);

				grpWeekText.members[curWeek].week.animation.resume();
				//grpWeekCharacters.members[1].animation.play('bfConfirm');
				stopspamming = true;
			}

			PlayState.storyPlaylist = weekData[curWeek];
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = "";

			switch (curDifficulty)
			{
				case 0:
					diffic = '-easy';
				case 2:
					diffic = '-hard';
				case 3:
					diffic = '-getreal';
			}

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.storyWeek = curWeek;
			PlayState.returnLocation = "main";
			PlayState.campaignScore = 0;
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				if (FlxG.sound.music != null)
					FlxG.sound.music.stop();
				FlxG.switchState(new PlayState());
			});
		}
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 3;
		if (curDifficulty > 3)
			curDifficulty = 0;

		sprDifficulty.offset.x = 0;

		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('easy');
				//sprDifficulty.offset.x = 20;
			case 1:
				sprDifficulty.animation.play('normal');
				//sprDifficulty.offset.x = 70;
			case 2:
				sprDifficulty.animation.play('hard');
				//sprDifficulty.offset.x = 20;
			case 3:
				sprDifficulty.animation.play('getreal');
				//sprDifficulty.offset.x = 70;
		}

		sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		sprDifficulty.y = 15;
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end

		FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;
		coolerArrows.y = 180 +20 * change;
		FlxTween.tween(coolerArrows, {y:180}, 0.2,{ease:FlxEase.circOut});
		if (curWeek >= weekData.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = weekData.length - 1;

		sprDifficulty.frames = FlxAtlasFrames.fromSparrow("assets/images/menu/diff.png","assets/images/menu/diff.xml");
		sprDifficulty.animation.addByIndices('easy', 'diff',[0],"");
		sprDifficulty.animation.addByIndices('normal', 'diff',[1],"");
		sprDifficulty.animation.addByIndices('hard', 'diff',[2],"");
		sprDifficulty.animation.addByIndices('getreal', 'diff',[3],"");
		bd.animation.play("bd", true, false, curWeek);
		changeDifficulty();

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && weekUnlocked[curWeek]){
				item.alpha = 1;
				item.scale.x = item.scale.y = 1.6;
			}else{
				item.alpha = 0.5;
				item.scale.x = item.scale.y = 1.3;
			}
			bullShit++;
		}

		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);

		updateText();
	}

	function updateText()
	{
		//grpWeekCharacters.members[0].animation.play(weekCharacters[curWeek][0]);
		//grpWeekCharacters.members[1].animation.play(weekCharacters[curWeek][1]);
		//grpWeekCharacters.members[2].animation.play(weekCharacters[curWeek][2]);
		txtTracklist.text = "Tracks\n";
/*
		switch (grpWeekCharacters.members[0].animation.curAnim.name)
		{
			case 'parents-christmas':
				grpWeekCharacters.members[0].offset.set(200, 200);
				grpWeekCharacters.members[0].setGraphicSize(Std.int(grpWeekCharacters.members[0].width * 0.99));

			case 'senpai':
				grpWeekCharacters.members[0].offset.set(130, 0);
				grpWeekCharacters.members[0].setGraphicSize(Std.int(grpWeekCharacters.members[0].width * 1.4));

			case 'mom':
				grpWeekCharacters.members[0].offset.set(100, 200);
				grpWeekCharacters.members[0].setGraphicSize(Std.int(grpWeekCharacters.members[0].width * 1));

			case 'dad':
				grpWeekCharacters.members[0].offset.set(120, 200);
				grpWeekCharacters.members[0].setGraphicSize(Std.int(grpWeekCharacters.members[0].width * 1));

			default:
				grpWeekCharacters.members[0].offset.set(100, 100);
				grpWeekCharacters.members[0].setGraphicSize(Std.int(grpWeekCharacters.members[0].width * 1));
				// grpWeekCharacters.members[0].updateHitbox();
		}
*/
		var stringThing:Array<String> = weekData[curWeek];

		for (i in stringThing)
		{
			txtTracklist.text += "\n" + i;
		}

		txtTracklist.text += "\n";

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.setPosition(950,100);

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end
	}
}
