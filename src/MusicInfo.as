package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class MusicInfo extends Sprite
	{
		private var _id:String;
		private var title:String;
		private var artist:String;
		private var genre:String;
		private var key:String;
		private var price:String;
		private var _resultTitle:TextField;
		private var _resultFormat:TextFormat = new TextFormat();
		private var _resultArtist:TextField;
		private var _resultGenre:TextField;
		private var _resultKey:TextField;
		private var _resultPrice:TextField;
		
		public function MusicInfo(MusicVO:Object, x:uint,y:uint)
		{
			super();
			formatText();
		}
		
		public function get id():String
		{
			return _id;
		}

		private function formatText():void
		{
			_resultFormat.color = 0x000000;
			_resultFormat.font = "Droid Sans";
			_resultFormat.size = 16;
		}
		
		private function musicResults():void
		{
			var vo:MusicVO:String = new MusicVO();
				
			_resultTitle = new TextField();
			addChild(_resultTitle);
			_resultTitle.defaultTextFormat = _resultFormat;
			_resultTitle.border = false;
			_resultTitle.width = 400;
			_resultTitle.height = 30;	
			_resultTitle.text = vo.title; 
			
				
			_resultArtist = new TextField();
			addChild(_resultArtist);
			_resultArtist.defaultTextFormat = _resultFormat;
			_resultArtist.border = false;
			_resultArtist.width = 275;
			_resultArtist.height = 30;
			_resultArtist.text = vo.artist;

				
			_resultGenre = new TextField();
			addChild(_resultGenre);
			_resultGenre.defaultTextFormat = _resultFormat;
			_resultGenre.border = false;
			_resultGenre.width = 120;
			_resultGenre.height = 30;
			_resultGenre.text = vo.genre;

				
			_resultKey = new TextField();
			addChild(_resultKey);
			_resultKey.defaultTextFormat = _resultFormat;
			_resultKey.border = false;
			_resultKey.width = 100;
			_resultKey.height = 30;
			_resultKey.text = vo.key;
				
			_resultPrice = new TextField();
			addChild(_resultPrice);
			_resultPrice.defaultTextFormat = _resultFormat;
			_resultPrice.border = false;
			_resultPrice.width = 60;
			_resultPrice.height = 30;
			_resultPrice.text = vo.price;
			
		}

	}
	
}