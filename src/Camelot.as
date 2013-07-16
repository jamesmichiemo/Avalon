package
{
	import flash.display.Sprite;
	
	public class Camelot extends Sprite
	{
		
		private var _vo:MusicVO;
		private var _queryFirstTone:Number;
		private var _querySecondTone:Number;
		private var _queryFirstMode:String;
		private var _querySecondMode:String;
		
		public function Camelot()
		{
			super();
			
			
			_querySecondTone = _vo.tone;
			
			_querySecondMode = _vo.mode;
			
			trace("tone1: " + _queryFirstTone);
			trace("tone2: " + _querySecondTone);
			trace("mode1: " + _queryFirstMode);
			trace("mode2: " + _querySecondMode);
			
			
			// Function1: Do the song play well together?
			var harmony:Boolean = harmonyBlend();
			
			
			printMessage(harmony);			
		}
		
		// Function1: Do the songs play well together?
		private function harmonyBlend():Boolean
		{
			//declare harmonyBlend variable for the following conditional arguement
			var harmonyBlend:Boolean = false;
			
			// Calculate compatibility based on Harmonic Mixing Camelot Wheel Chart
			if(Number(_queryFirstTone) == Number(_querySecondTone)) // identical, either major or minor
			{
				// Perfect Match!
				trace("Perfect Match!");
				harmonyBlend = true;		
			}else if((Number(_queryFirstTone) == 12 && Number(_querySecondTone) == 1) && _queryFirstMode == _querySecondMode) // 1 and 12 are adjacent, same mode
			{
				trace("Perfect Match 1 and 12 are adjecent");
				harmonyBlend = true;
			}else if((Number(_queryFirstTone) == 1 && Number(_querySecondTone) == 12) && _queryFirstMode == _querySecondMode) // 1 and 12 are adjacent, same mode
			{
				trace("Perfect Match 1 and 12 are adjecent");
				harmonyBlend = true;
			}else if(Number(_queryFirstTone) == (Number(_querySecondTone) - 1) && _queryFirstMode == _querySecondMode) // 1 semitone down, same mode
			{
				trace("Perfect Match 1down")
				harmonyBlend = true;	
			}else if((Number(_queryFirstTone)) == (Number(_querySecondTone) + 1) && _queryFirstMode == _querySecondMode) // 1 semitone up, same mode 
			{
				trace("Perfect Match 1up")
				harmonyBlend = true;
			}else
			{
				trace("Not a match!");
				harmonyBlend = false;
			}
			
			
			harmonyBlend = harmonyBlend;
			// transfer value to main
			return harmonyBlend;
		}
		
		// Function2: Do the songs play well together?
		private function printMessage(harmony:Boolean):void
		{
			// trace out the results based on Function1
			if(harmony == true)
			{
				trace("match");
			} else{
				trace("clash");
			}
		}
	}
}