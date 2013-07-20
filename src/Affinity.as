package
{
	import flash.display.Sprite;
	
	public class Affinity extends Sprite
	{
		
		public function Affinity()
		{
			super();		
		}
		
		// Function 1
		public static function harmonyBlend(traitOne:Number, traitTwo:Number, ougiOne:String, ougiTwo:String):Boolean
		{
	
			var queryFirstTrait:Number = traitOne;
			var querySecondTrait:Number = traitTwo;
			var queryFirstOugi:String = ougiOne;
			var querySecondOugi:String = ougiTwo;
			
			
			//declare harmonyBlend variable for the following conditional arguement
			var harmonyBlend:Boolean = false;
			
			// affinity burst
			if((Number(queryFirstTrait) == Number(querySecondTrait)) || // identical, either major or minor
			   ((Number(queryFirstTrait) == 24 && Number(querySecondTrait) == 13) && queryFirstOugi == querySecondOugi) || // 13 and 24 are loop ougi affinite
			   ((Number(queryFirstTrait) == 13 && Number(querySecondTrait) == 24) && queryFirstOugi == querySecondOugi) || // 24 and 13 are loop ougi affinite
			   ((Number(queryFirstTrait) == (Number(querySecondTrait) - 1) && queryFirstOugi == querySecondOugi) || // ougi sequence
			   ((Number(queryFirstTrait)) == (Number(querySecondTrait) + 1) && queryFirstOugi == querySecondOugi)) // ougi sequence				   
			  )
			{
				// Perfect Match!
				trace("match");
				harmonyBlend = true;		
			}else
			{
				trace("clash");
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