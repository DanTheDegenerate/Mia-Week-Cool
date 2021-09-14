package;
import flixel.*;
/**
 * ...
 * @author bbpanzu
 */
class CoryState extends MusicBeatState
{

	public function new() 
	{
		
		super();
	}
	
	
	override function create() 
	{
		PlayState.SONG = {
			
	song:"ttttttt",
	notes:[],
	bpm:44,
	needsVoices:false,
	speed:6,

	player1:"reclaimableSlurs",
	player2:"bitch",
	validScore:false
			
			
			
		};
		super.create();
		
		var dialogue:Array<String> = CoolUtil.coolTextFile("assets/data/ilycory.txt");
		var dia:DialogueBox = new DialogueBox(false, dialogue);
		dia.finishThing = enddd;
		
		add(dia);
	}
	
	function enddd(){
			FlxG.switchState(new TitleStateNormal());
	}
	
}





