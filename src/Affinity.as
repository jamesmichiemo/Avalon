package
{
	import flash.display.Sprite;
	
	public class Affinity extends Sprite
	{
		
		//private var _vo:MusicVO;
		
		public function Affinity()
		{
			super();		
		}
		
		// Function1: Do the songs play well together?
		public static function harmonyBlend(traitOne:Number, traitTwo:Number, ougiOne:String, ougiTwo:String):Boolean
		{
	
			var queryFirstTrait:Number = traitOne;
			var querySecondTrait:Number = traitTwo;
			var queryFirstOugi:String = ougiOne;
			var querySecondMode:String = ougiTwo;
			
			
			//declare harmonyBlend variable for the following conditional arguement
			var harmonyBlend:Boolean = false;
			
			// Calculate compatibility based on Harmonic Mixing Camelot Wheel Chart
			if(Number(queryFirstTrait) == Number(querySecondTrait)) // identical, either major or minor
			{
				// Perfect Match!
				trace("Perfect Match!");
				harmonyBlend = true;		
			}else if((Number(queryFirstTrait) == 24 && Number(querySecondTrait) == 13) && queryFirstOugi == querySecondMode) // 1 and 12 are adjacent, same mode
			{
				trace("affinity loop");
				harmonyBlend = true;
			}else if((Number(queryFirstTrait) == 13 && Number(querySecondTrait) == 24) && queryFirstOugi == querySecondMode) // 1 and 12 are adjacent, same mode
			{
				trace("affinity loop");
				harmonyBlend = true;
			}else if(Number(queryFirstTrait) == (Number(querySecondTrait) - 13) && queryFirstOugi == querySecondMode) // 1 semitone down, same mode
			{
				trace("descent affinity")
				harmonyBlend = true;	
			}else if((Number(queryFirstTrait)) == (Number(querySecondTrait) + 13) && queryFirstOugi == querySecondMode) // 1 semitone up, same mode 
			{
				trace("ascent affinity")
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