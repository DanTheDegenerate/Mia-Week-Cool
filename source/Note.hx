package;

import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
//import polymod.format.ParseRules.TargetSignatureElement;

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var glowPath:String = (Config.noteGlow) ? "fpsPlus/" : "";
	public var prevNote:Note;
	public var absoluteNumber:Int;
	
	
	//HOW TO MAKE CUSTOM NOTES!!!!
	
	/*
	 
	1. Note.hx-
		add onto the noteStyles array for whatever notes ya want
		
	2. PlayState-
		on the goodNoteHit function or the noteMiss funtion, just do a 
		if(daNote.noteStyle == whateverstylenumber){
			doABitch();
			eatass ++;
			health= -48958;
		
		}
	
	
	 */
	public var noteStyle:Int = 0;
	public static var noteStyles:Array<String> = ["normal", "cock", "shoot", "death"];
	
	public static var NORMAL_NOTE = 0;
	public static var COCK_NOTE = 1;// :P
	public static var SHOOT_NOTE = 2;
	public static var DEATH_NOTE = 3;

	public var isEnd:Bool = false;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var noteScore:Float = 1;

	public var playedEditorClick:Bool = false;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;
	
	public var aight:Int = 0;

	public function new(_strumTime:Float, _noteData:Int, ?_editor = false, ?_prevNote:Note, ?_sustainNote:Bool = false,noteStyle:Int=0)
	{
		super();

		if (_prevNote == null)
			_prevNote = this;

		prevNote = _prevNote;
		isSustainNote = _sustainNote;
		this.noteStyle = noteStyle;
		x += 100;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		
		if(!_editor){
			strumTime = _strumTime + Config.offset;
			if(strumTime < 0) {
				strumTime = 0;
			}
		}
		else {
			strumTime = _strumTime;
		}

		noteData = _noteData;

		var daStage:String = PlayState.curStage;

		switch (daStage)
		{
			case 'school' | 'schoolEvil':
				loadGraphic('assets/images/' + glowPath + 'weeb/pixelUI/arrows-pixels.png', true, 17, 17);

				animation.add('greenScroll', [6]);
				animation.add('redScroll', [7]);
				animation.add('blueScroll', [5]);
				animation.add('purpleScroll', [4]);

				if(Config.noteGlow){
					animation.add('green glow', [22]);
					animation.add('red glow', [23]);
					animation.add('blue glow', [21]);
					animation.add('purple glow', [20]);
				}

				if (isSustainNote)
				{
					loadGraphic('assets/images/weeb/pixelUI/arrowEnds.png', true, 7, 6);

					animation.add('purpleholdend', [4]);
					animation.add('greenholdend', [6]);
					animation.add('redholdend', [7]);
					animation.add('blueholdend', [5]);

					animation.add('purplehold', [0]);
					animation.add('greenhold', [2]);
					animation.add('redhold', [3]);
					animation.add('bluehold', [1]);
				}

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();

			default:
				var notepath = glowPath + 'NOTE_assets';
				if (noteStyle == DEATH_NOTE){
					notepath = 'kill notes';
				}
				trace(notepath);
				frames = FlxAtlasFrames.fromSparrow('assets/images/' + notepath + '.png', 'assets/images/' + notepath + '.xml');

				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');

				animation.addByPrefix('purpleholdend', 'pruple end hold');
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');

				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');
				
					animation.addByPrefix('green', 'arrowUP');
					animation.addByPrefix('blue', 'arrowDOWN');
					animation.addByPrefix('purple', 'arrowLEFT');
					animation.addByPrefix('red', 'arrowRIGHT');


				if(Config.noteGlow){
					animation.addByPrefix('purple glow', 'Purple Active');
					animation.addByPrefix('green glow', 'Green Active');
					animation.addByPrefix('red glow', 'Red Active');
					animation.addByPrefix('blue glow', 'Blue Active');
				}

				setGraphicSize(Std.int(width * 0.7));
				updateHitbox();
				
				
				if (noteStyle == DEATH_NOTE){
					setGraphicSize(Std.int(width * 0.8));
					updateHitbox();
					offset.x= 30;//offset debuging. you do it im a bit tired
					offset.y = 0;
				}
				
				
				antialiasing = true;
		}

		switch (noteData)
		{
			case 0:
				x += swagWidth * 0;
				animation.play('purpleScroll');
			case 1:
				x += swagWidth * 1;
				animation.play('blueScroll');
			case 2:
				x += swagWidth * 2;
				animation.play('greenScroll');
			case 3:
				x += swagWidth * 3;
				animation.play('redScroll');
		}

		// trace(prevNote);

		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			alpha = 0.6;

			x += width / 2;
			
			flipY = Config.downscroll;

			switch (noteData)
			{
				case 2:
					animation.play('greenholdend');
				case 3:
					animation.play('redholdend');
				case 1:
					animation.play('blueholdend');
				case 0:
					animation.play('purpleholdend');
			}

			isEnd = true;
			
			

			updateHitbox();

			x -= width / 2;

			if (PlayState.curStage.startsWith('school'))
				x += 30;

			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 2:
						prevNote.animation.play('greenhold');
					case 3:
						prevNote.animation.play('redhold');
					case 1:
						prevNote.animation.play('bluehold');
					case 0:
						prevNote.animation.play('purplehold');
				}

				prevNote.offset.y = -19;
				prevNote.scale.y *= (2.25 * FlxMath.roundDecimal(PlayState.SONG.speed, 1));
				// prevNote.setGraphicSize();
			}
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

			if (noteStyle == 1) 
					animation.play('purple');
			if (noteStyle == 2)
					animation.play('red');
		
		
		if (mustPress)
		{
			if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
				&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * (isSustainNote ? 0.5 : 1)))
			{
				canBeHit = true;
			}
			else
				canBeHit = false;

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset)
				tooLate = true;

			}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
			{
				wasGoodHit = true;
			}
		}

		if (canBeHit && Config.noteGlow && !isSustainNote){
			switch (noteData)
			{
				case 2:
					animation.play('green glow');
				case 3:
					animation.play('red glow');
				case 1:
					animation.play('blue glow');
				case 0:
					animation.play('purple glow');
			}
		}

	}
}
