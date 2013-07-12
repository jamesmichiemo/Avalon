package
{
	public class MusicDisplay extends SlimDisplayBase
	{
		private var _data:MusicVO;
		public function MusicDisplay()
		{
			super();
		}
		
		public function set data(value:MusicVO):void
		{
			_data = value;
		}

		public function get data():MusicVO
		{
			return _data;
		}
		
		private function updateTextFields():void
		{
			tfTitle.text = _data.title;
			tfArtist.text = _data.artist;
			tfGenre.text = _data.genre;
			tfKey.text = _data.key;
			tfKeycode.text = _data.keycode;
			tfPrice.text = _data.price;
		}
		
	}
}