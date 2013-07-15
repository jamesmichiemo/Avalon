package
{

	import flash.display.DisplayObjectContainer;
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
		private var _query:String;
		private var searchFormat:TextFormat = new TextFormat();
		private var _musicDisplay:MusicDisplay;
		private var _vos:Array;
		private var _resultTitle:TextField;
		private var _resultArtist:TextField;
		private var _resultGenre:TextField;
		private var _resultKey:TextField;
		private var _resultPrice:TextField;
		private var resultFormat:TextFormat = new TextFormat();
		private var _resultsQuery:String;
		private var _vosResult:Array;
		
		public function Main()
		{
			formatText();	
			createSearchField();
			createButton();
		}
		
		private function createButton():void
		{
			
			var button:BoxBase = new BoxBase();
			this.addChild(button);
			button.x = _searchField.x +405;
			button.y = _searchField.y;
			button.scaleX = button.scaleY = .6;
			button.tfLabel.text = "Search";
			button.tfLabel.x = -15;
			button.tfLabel.y = 1;
			button.tfLabel.scaleX = button.tfLabel.scaleY = 1.8;
			button.mouseChildren = false;
			button.buttonMode = true;

			button.addEventListener(MouseEvent.MOUSE_UP, onSearch);
			
		}
		
		private function formatText():void
		{
			searchFormat.color = 0x000000;
			searchFormat.font = "Droid Sans";
			searchFormat.size = 22;
			
			resultFormat.color = 0x000000;
			resultFormat.font = "Droid Sans";
			resultFormat.size = 16;
			
		}
		
		private function createSearchField():void
		{
			
			_searchField = new TextField();
			this.addChild(_searchField);
			_searchField.defaultTextFormat = searchFormat;
			_searchField.border = true;
			_searchField.x = 10;
			_searchField.y = 10;
			_searchField.width = 400;
			_searchField.height = 30;
			_searchField.type = TextFieldType.INPUT;
			_searchField.text = "Search Artist, Label or Track";
			
		}
		
		protected function onSearch(event:MouseEvent):void
		{	
			
			//http://snipplr.com/view/10717/
			var _scope:DisplayObjectContainer = this;
			trace(_scope.numChildren);
			while(_scope.numChildren > 2)
			{
				_scope.removeChildAt(_scope.numChildren-1);
			}
			trace(_scope.numChildren);
			
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
			
			_vos = [];
			
			var jsonData:Object = JSON.parse(event.currentTarget.data + "");
			
			for each(var resultsNode:Object in jsonData.results)
			{
				if(resultsNode.title != undefined &&
					resultsNode.artists != undefined &&
					resultsNode.genres != undefined &&
					resultsNode.key != undefined && 
					resultsNode.key.shortName != undefined &&
					resultsNode.price != undefined && 
					resultsNode.price.display != undefined)
				{
					var vo : MusicVO = new MusicVO();
					vo.id = resultsNode.id;
					vo.title = resultsNode.title;
					vo.artist = resultsNode.artists[0].name;
					vo.genre = resultsNode.genres[0].name;
					vo.key = resultsNode.key.shortName;
					vo.price = resultsNode.price.display;
					
					_vos.push(vo);
				}else{
					trace("undefined");
				}
			}

			for each (var object : MusicVO in _vos)
			{
				trace("-------------------------------")
				trace(object.id);
				trace(object.title);
				trace(object.artist);
				trace(object.genre);
				trace(object.key);
			}
			
			 
			createResults();
			
		}
		
		private function createResults():void
		{
			
			for(var i:uint=0;i<_vos.length; i++)
			{	
			var mf:MusicInfo = new MusicInfo(_vos[i],(i*30)+240);
			this.addChild(mf);
			mf.addEventListener(MouseEvent.MOUSE_UP, onResultSearch);
			}
		}

			
		
		protected function onBuy(event:MouseEvent):void
		{
			//navigateToURL(new URLRequest("http"), "_blank");
		
		}
		
		protected function onResultSearch(event:MouseEvent):void
		{
			
			//http://snipplr.com/view/10717/
			var _scope:DisplayObjectContainer = this;
			trace(_scope.numChildren);
			while(_scope.numChildren > 2)
			{
				_scope.removeChildAt(_scope.numChildren-1);
			}
			trace(_scope.numChildren);
			
			_resultsQuery = event.currentTarget.id;
			trace(_resultsQuery);
			getResultSearchList();
			
		}
		
		private function getResultSearchList():void
		{
			
			var ul:URLLoader = new URLLoader();
			ul.load(new URLRequest("http://api.beatport.com/catalog/3/tracks/similar?ids=" + _resultsQuery));
			ul.addEventListener(Event.COMPLETE, onParse);
			
		}
	
	}
	
}