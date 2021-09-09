package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;

class MenuItem extends FlxSpriteGroup
{
	public var targetY:Float = 0;
	public var week:FlxSprite;

	public function new(x:Float, y:Float, weekNum:Int = 0)
	{
		super(x, y);

		var tex;

		
		
		week = new FlxSprite();
		
		if (weekNum == 7){
			week.loadGraphic('assets/images/y_1.png');
			week.offset.y -= 15;
			week.offset.x -= 25;
			week.scale.x = week.scale.y = 0.2;
			week.updateHitbox();
		}else{
			
		tex = FlxAtlasFrames.fromSparrow('assets/images/campaign_menu_UI_assets.png', 'assets/images/campaign_menu_UI_assets.xml');
		
		
			week.frames = tex;
			
		
			
		// TUTORIAL IS WEEK 0
		week.animation.addByPrefix('week0', 'tutorial selected', 24);
		week.animation.addByPrefix('week1', "WEEK1 select", 24);
		week.animation.addByPrefix('week2', "week2 select", 24);
		week.animation.addByPrefix('week3', "Week 3 press", 24);
		week.animation.addByPrefix('week4', "Week 4 press", 24);
		week.animation.addByPrefix('week5', "week 5", 24);
		week.animation.addByPrefix('week6', "Week 6", 24);
		week.animation.addByPrefix('week7', 'tutorial selected', 24);
		week.animation.addByPrefix('week8', "WEEK1 select", 24);
		week.animation.addByPrefix('week9', "week2 select", 24);
		week.animation.addByPrefix('week10', "Week 3 press", 24);
		week.animation.addByPrefix('week11', "Week 4 press", 24);
		week.animation.addByPrefix('week12', "week 5", 24);
		week.animation.addByPrefix('week13', "Week 6", 24);
		week.animation.play('week' + (weekNum));
		week.animation.pause();
		}
		week.antialiasing = true;
		add(week);
	}
	

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		y = FlxMath.lerp(y, (targetY * 240) + 300, 0.17);
	}
}
