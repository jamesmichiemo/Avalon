package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	
	[SWF(width="980", height="500", framerate="60", backgroundColor="0xededed")]
	public class Main extends Sprite
	{
		private var _searchField:TextField;
		private var _searchTitleResults:Array;
		private var _searchArtistResults:Array;
		private var _searchKeyResults:Array;
		private var _searchGenreResults:Array;
		private var _searchPriceResults:Array;
		private var _query:String;
		private var format:TextFormat = new TextFormat();
		;
		private var _vo:MusicVO;
		private var _searchIdResults:Array;
		private var _musicDisplay:MusicDisplay;
		public function Main()
		{
			formatText();	
			createSearchField();
			createButton();
		}
		
		private function createButton():void
		{
			var button:ButtonBase = new ButtonBase();
			this.addChild(button);
			button.x = _searchField.x +400;
			button.y = _searchField.y +5;
			button.scaleX = button.scaleY = .6;
			button.tfLabel.text = "Search";
			button.mouseChildren = false;
			button.buttonMode = true;
			
			button.addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		private function formatText():void
		{
			format.color = 0x000000;
			format.font = "Droid Sans";
			format.size = 22;
		}
		
		private function createSearchField():void
		{
			_searchField = new TextField();
			this.addChild(_searchField);
			_searchField.defaultTextFormat = format;
			_searchField.border = true;
			_searchField.x = 10;
			_searchField.y = 10;
			_searchField.width = 400;
			_searchField.height = 30;
			_searchField.type = TextFieldType.INPUT;
			_searchField.text = "Search Artist, Label or Track";
			
			_musicDisplay = new MusicDisplay();
			addChild(_musicDisplay);
			_musicDisplay.y = 60;
			
			_vo = new MusicVO();
			_vo.title = "?";
			_vo.artist = "?";
			_vo.genre = "?";
			_vo.key = "?";
			_vo.keycode = "?";
			_vo.price = "?";
			
			_musicDisplay.data = _vo;
		}
		
		protected function onUp(event:MouseEvent):void
		{
			_searchIdResults = [];
			_searchTitleResults = [];
			_searchArtistResults = [];
			_searchKeyResults = [];
			_searchGenreResults = [];
			_searchPriceResults = [];
			
			_query = _searchField.text;
			getSearchList();			
		}
		
		private function getSearchList():void
		{
			var ul:URLLoader = new URLLoader();
			ul.load(new URLRequest("http://api.beatport.com/catalog/3/search?query=" + _query));
			ul.addEventListener(Event.COMPLETE, onParse);
		}
		
		protected function onParse(event:Event):void
		{	
			_searchIdResults = [];
			_searchTitleResults = [];
			_searchArtistResults = [];
			_searchKeyResults = [];
			_searchGenreResults = [];
			_searchPriceResults = [];
			
			var jsonData:Object = JSON.parse(event.currentTarget.data + "");
			
			for each(var resultsNode:Object in jsonData.results)
			{
				if(resultsNode.title != undefined &&
				   resultsNode.artists != undefined &&
				   resultsNode.genres != undefined &&
				   resultsNode.key != undefined && 
				   resultsNode.key.shortName != undefined &&
				   resultsNode.audioFormatFee != undefined && 
				   resultsNode.audioFormatFee.wav.display != undefined)
				{
					trace("id: " + resultsNode.id)
					_searchIdResults.push(resultsNode.id);
					
					trace("title: " + resultsNode.title)
					_vo.title = resultsNode.title;
					_searchTitleResults.push(resultsNode.title);
					
					trace("artist: " + resultsNode.artists[0].name);
					_vo.artist = resultsNode.artists[0].name;
					_searchArtistResults.push(resultsNode.artists[0].name);
					
					trace("genre: " + resultsNode.genres[0].name);
					_vo.genre = resultsNode.genres[0].name;
					_searchGenreResults.push(resultsNode.genres[0].name);
					
					trace("key: " + resultsNode.key.shortName);
					_vo.key = resultsNode.key.shortName;
					_searchKeyResults.push(resultsNode.key.shortName);
					
					trace("buy: " + resultsNode.audioFormatFee.wav.display);
					_vo.price = resultsNode.audioFormatFee.wav.display;
					_searchKeyResults.push(resultsNode.audioFormatFee.wav.display);
					
					_musicDisplay.data = _vo;
					
				}else{
					trace("undefined");
				}
			}
		}
	}
}