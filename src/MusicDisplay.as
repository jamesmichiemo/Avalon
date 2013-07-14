package
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class MusicDisplay extends SlimDisplayBase
	{
		private var _data:MusicVO;
		private var _resultTitle:TextField;
		private var format:TextFormat = new TextFormat();
		private var _resultArtist:TextField;
		private var _resultGenre:TextField;
		private var _resultKey:TextField;
		private var _resultPrice:TextField;
		
		public function MusicDisplay()
		{
			super();
			formatText();
		}
		
		private function formatText():void
		{
			format.color = 0x000000;
			format.font = "Droid Sans";
			format.size = 22;
		}
		
		public function set data(value:MusicVO):void
		{
			_data = value;
		}

		public function get data():MusicVO
		{
			return _data;
		}
		
//		private function updateTextFields():void
//		{
//			 = _data.title;
//			tfArtist.text = _data.artist;
//			tfGenre.text = _data.genre;
//			tfKey.text = _data.key;
//			tfKeycode.text = _data.keycode;
//			tfPrice.text = _data.price;
//		}


//		private function createResults():void
//		{
//			_resultTitle = new TextField();
//			this.addChild(_resultTitle);
//			_resultTitle.defaultTextFormat = format;
//			_resultTitle.border = true;
//			_resultTitle.x = 10;
//			_resultTitle.y = 40;
//			_resultTitle.width = 300;
//			_resultTitle.height = 30;
//			_resultTitle.text = _data.artist;
//			
//			_resultArtist = new TextField();
//			this.addChild(_resultArtist);
//			_resultArtist.defaultTextFormat = format;
//			_resultArtist.border = true;
//			_resultArtist.x = 310;
//			_resultArtist.y = 40;
//			_resultArtist.width = 200;
//			_resultArtist.height = 30;
//			_resultArtist.text = _data.artist;
//			
//			_resultGenre = new TextField();
//			this.addChild(_resultGenre);
//			_resultGenre.defaultTextFormat = format;
//			_resultGenre.border = true;
//			_resultGenre.x = 520;
//			_resultGenre.y = 40;
//			_resultGenre.width = 100;
//			_resultGenre.height = 30;
//			_resultGenre.text = _data.genre;
//			
//			_resultKey = new TextField();
//			this.addChild(_resultKey);
//			_resultKey.defaultTextFormat = format;
//			_resultKey.border = true;
//			_resultKey.x = 630;
//			_resultKey.y = 40;
//			_resultKey.width = 60;
//			_resultKey.height = 30;
//			_resultKey.text = _data.key;
//			
//			_resultPrice = new TextField();
//			this.addChild(_resultPrice);
//			_resultPrice.defaultTextFormat = format;
//			_resultPrice.border = true;
//			_resultPrice.x = 700;
//			_resultPrice.y = 40;
//			_resultPrice.width = 60;
//			_resultPrice.height = 30;
//			_resultPrice.text = data.price;
//			
//		}
		
	}
}