package;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var songs:Array<CredsMetadata> = [];

	public static var startingSelection:Int = 0;
	var selector:FlxText;
	public static var curSelected:Int = 0;
	static var curDifficulty:Int = 1;

	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	override function create()
	{

		openfl.Lib.current.stage.frameRate = 144;

		var initCredlist = CoolUtil.coolTextFile('assets/data/credslist.txt');

		curSelected = 0;

		songs.push(new CredsMetadata("The Official Twitter Account", 1, 'bf'));
		
		songs.push(new CredsMetadata("MUSICIANS", 999, 'title'));
		songs.push(new CredsMetadata("Biddle3", 0, ''));
		songs.push(new CredsMetadata("VOICE ACTORS", 999, 'title'));
		songs.push(new CredsMetadata("spiteater", 0, ''));
		songs.push(new CredsMetadata("ARTISTS and ANIMATORS", 999, 'title'));
		
		songs.push(new CredsMetadata("SugarRatio", 2, ''));
		songs.push(new CredsMetadata("Moisty", 3, ''));
		songs.push(new CredsMetadata("Shell", 4, ''));
		songs.push(new CredsMetadata("BlazeTheWolf55", 4, ''));
		songs.push(new CredsMetadata("NeatoNG_", 5, ''));
		songs.push(new CredsMetadata("Cval", 5, ''));
		songs.push(new CredsMetadata("Deca", 5, ''));
		songs.push(new CredsMetadata("PacioFD", 5, ''));
		songs.push(new CredsMetadata("DanTheMan", 6, ''));
		songs.push(new CredsMetadata("Johnscomics3", 6, ''));
		songs.push(new CredsMetadata("Jams3D", 6, ''));
		songs.push(new CredsMetadata("Teethlust", 6, ''));
		
		songs.push(new CredsMetadata("PROGRAMMERS", 999, 'title'));
		songs.push(new CredsMetadata("KadeDeveloper", 5, ''));
		songs.push(new CredsMetadata("bbpanzu", 5, ''));
		songs.push(new CredsMetadata("Sulayre", 5, ''));
		songs.push(new CredsMetadata("Cval", 5, ''));
		
		songs.push(new CredsMetadata("CHARTERS", 10, 'title'));
		songs.push(new CredsMetadata("Cval", 5, ''));
		songs.push(new CredsMetadata("DanTheMan", 5, ''));
		songs.push(new CredsMetadata("FoxeruKun", 5, ''));

		var isDebug:Bool = true;

		/*if (StoryMenuState.weekUnlocked[2] || isDebug)
			addWeek(['Bopeebo', 'Fresh', 'Dadbattle'], 1, ['dad']);*/

		/*if (StoryMenuState.weekUnlocked[2] || isDebug)
			addWeek(['Spookeez', 'South', 'Monster'], 2, ['spooky', 'spooky', "monster"]);

		if (StoryMenuState.weekUnlocked[2] || isDebug)
			addWeek(['Pico', 'Philly', 'Blammed'], 3, ['pico']);

		if (StoryMenuState.weekUnlocked[4] || isDebug)
			addWeek(['Satin-Panties', 'High', 'Milf'], 4, ['mom']);

		if (StoryMenuState.weekUnlocked[5] || isDebug)
			addWeek(['Cocoa', 'Eggnog', 'Winter-Horrorland'], 5, ['parents-christmas', 'parents-christmas', 'monster-christmas']);

		if (StoryMenuState.weekUnlocked[6] || isDebug)
			addWeek(['Senpai', 'Roses', 'Thorns'], 6, ['senpai', 'senpai-angry', 'spirit']);*/

		// LOAD MUSIC
		/*for(x in songs){
			FlxG.sound.cache('assets/music/' + x.songName + "_Inst" + TitleState.soundExt);
		}*/

		// LOAD CHARACTERS

		var bg:FlxSprite = new FlxSprite().makeGraphic(1280,720,0xFFFFFFCC);
		add(bg);
		
		var bgg:FlxSprite = new FlxSprite( -175.8, -124.2).loadGraphic("assets/images/dialoguecheckerboard.png");
		FlxTween.tween(bgg, {x:0, y:0}, 2, {type:LOOPING});
		add(bgg);


		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var leng = 0;
			if (songs[i].songCharacter == "title") leng = 30;
			var songText:Alphabet = new Alphabet(0, (70 * i) + leng, songs[i].songName, songs[i].songCharacter == "title", false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);

			//var icon:HealthIcon = new HealthIcon(songs[i].songCharacter, i);
			//icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			//iconArray.push(icon);
			//add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

		/*scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		// scoreText.autoSize = false;
		scoreText.setFormat("assets/fonts/vcr.ttf", 32, FlxColor.WHITE, RIGHT);
		// scoreText.alignment = RIGHT;

		var scoreBG:FlxSprite = new FlxSprite(scoreText.x - 6, 0).makeGraphic(Std.int(FlxG.width * 0.35), 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		add(diffText);

		add(scoreText);

		changeSelection(startingSelection);
		changeDiff();*/

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));
			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;
			FlxG.stage.addChild(texFel);
			// scoreText.textField.htmlText = md;
			trace(md);
		 */

		super.create();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String)
	{
		songs.push(new CredsMetadata(songName, weekNum, songCharacter));
	}

	public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);

			if (songCharacters.length != 1)
				num++;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.4));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		/*scoreText.text = "PERSONAL BEST:" + lerpScore;*/

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}
		if (controls.BACK)
		{
			FlxG.sound.play('assets/sounds/cancelMenu' + TitleState.soundExt);
			FlxG.switchState(new MainMenuState());
		}

		if (accepted)
		{
				
				
			switch(songs[curSelected].songName){
				case "The Official Twitter Account":
				FlxG.openURL('https://twitter.com/b3fnf');
				case "Cval":
				FlxG.openURL('https://twitter.com/cval_brown');
				case "Shell":
				FlxG.openURL('https://twitter.com/Sh3llynn');
				case "bbpanzu":
				FlxG.openURL('https://twitter.com/bbsub3');
				case "DanTheMan":
				FlxG.openURL('https://www.youtube.com/channel/UC2n1_Ww41kLMuO4tKnKX37Q');
				case "Sulayre":
				FlxG.openURL('https://twitter.com/NewSrPerez');
				default:
					FlxG.openURL('https://twitter.com/'+songs[curSelected].songName);
					
			}
		}
	}

	/*function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		#end

		switch (curDifficulty)
		{
			case 0:
				diffText.text = "EASY";
			case 1:
				diffText.text = 'NORMAL';
			case 2:
				diffText.text = "HARD";
		}
	}*/

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt, 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		// lerpScore = 0;
		#end

		//FlxG.sound.playMusic('assets/music/' + songs[curSelected].songName + "_Inst" + TitleState.soundExt, 0);
		//FlxG.sound.music.fadeIn(1, 0, 0.8);

		var bullShit:Int = 0;

		//for (i in 0...iconArray.length)
		//{
		//	iconArray[i].alpha = 0.6;
		//}

		//iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}

class CredsMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";

	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
	}
}