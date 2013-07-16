package
{
	import flash.display.Sprite;
	
	public class Camelot extends Sprite
	{
		
		//private var _vo:MusicVO;
		
		public function Camelot()
		{
			super();		
		}
		
		// Function1: Do the songs play well together?
		public static function harmonyBlend(toneOne:Number, toneTwo:Number, modeOne:String, modeTwo:String):Boolean
		{
	
			var queryFirstTone:Number = toneOne;
			var querySecondTone:Number = toneTwo;
			var queryFirstMode:String = modeOne;
			var querySecondMode:String = modeTwo;
			
			
			//declare harmonyBlend variable for the following conditional arguement
			var harmonyBlend:Boolean = false;
			
			// Calculate compatibility based on Harmonic Mixing Camelot Wheel Chart
			if(Number(queryFirstTone) == Number(querySecondTone)) // identical, either major or minor
			{
				// Perfect Match!
				trace("Perfect Match!");
				harmonyBlend = true;		
			}else if((Number(queryFirstTone) == 12 && Number(querySecondTone) == 1) && queryFirstMode == querySecondMode) // 1 and 12 are adjacent, same mode
			{
				trace("Perfect Match 1 and 12 are adjecent");
				harmonyBlend = true;
			}else if((Number(queryFirstTone) == 1 && Number(querySecondTone) == 12) && queryFirstMode == querySecondMode) // 1 and 12 are adjacent, same mode
			{
				trace("Perfect Match 1 and 12 are adjecent");
				harmonyBlend = true;
			}else if(Number(queryFirstTone) == (Number(querySecondTone) - 1) && queryFirstMode == querySecondMode) // 1 semitone down, same mode
			{
				trace("Perfect Match 1down")
				harmonyBlend = true;	
			}else if((Number(queryFirstTone)) == (Number(querySecondTone) + 1) && queryFirstMode == querySecondMode) // 1 semitone up, same mode 
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