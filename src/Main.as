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
		//private var _vo:MusicVO;
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
			var button:ButtonBase = new ButtonBase();
			this.addChild(button);
			button.x = _searchField.x +400;
			button.y = _searchField.y +5;
			button.scaleX = button.scaleY = .6;
			button.tfLabel.text = "Search";
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
			var _scope:DisplayObjectContainer = this; // set the desired scope here, or below if you want to keep it to one line
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
			
			_resultTitle = new TextField();
			addChild(_resultTitle);
			_resultTitle.defaultTextFormat = resultFormat;
			_resultTitle.border = false;
			_resultTitle.x = 10;
			_resultTitle.y = (i*30)+240;
			_resultTitle.width = 400;
			_resultTitle.height = 30;
			_resultTitle.text = _vos[i].title;
			_resultTitle.addEventListener(MouseEvent.MOUSE_UP, onResultSearch);
						
			_resultArtist = new TextField();
			addChild(_resultArtist);
			_resultArtist.defaultTextFormat = resultFormat;
			_resultArtist.border = false;
			_resultArtist.x = 410;
			_resultArtist.y = (i*30)+240;
			_resultArtist.width = 275;
			_resultArtist.height = 30;
			_resultArtist.text = _vos[i].artist;
			
			_resultGenre = new TextField();
			addChild(_resultGenre);
			_resultGenre.defaultTextFormat = resultFormat;
			_resultGenre.border = false;
			_resultGenre.x = 685;
			_resultGenre.y = (i*30)+240;
			_resultGenre.width = 120;
			_resultGenre.height = 30;
			_resultGenre.text = _vos[i].genre;
			
			_resultKey = new TextField();
			addChild(_resultKey);
			_resultKey.defaultTextFormat = resultFormat;
			_resultKey.border = false;
			_resultKey.x = 805;
			_resultKey.y = (i*30)+240;
			_resultKey.width = 100;
			_resultKey.height = 30;
			_resultKey.text = _vos[i].key;
			
			_resultPrice = new TextField();
			addChild(_resultPrice);
			_resultPrice.defaultTextFormat = resultFormat;
			_resultPrice.border = false;
			_resultPrice.x = 905;
			_resultPrice.y = (i*30)+240;
			_resultPrice.width = 60;
			_resultPrice.height = 30;
			_resultPrice.text = _vos[i].price;
			}
		}
		
		protected function onResultSearch(event:MouseEvent):void
		{
			//http://snipplr.com/view/10717/
			var _scope:DisplayObjectContainer = this; // set the desired scope here, or below if you want to keep it to one line
			trace(_scope.numChildren);
			while(_scope.numChildren > 2)
			{
				_scope.removeChildAt(_scope.numChildren-1);
			}
			trace(_scope.numChildren);
			
			_resultsQuery = _vos[0].id;
			trace(_resultsQuery);
			getResultSearchList();
		}
		
		private function getResultSearchList():void
		{
			var ul:URLLoader = new URLLoader();
			ul.load(new URLRequest("http://api.beatport.com/catalog/3/tracks/similar?ids=" + _resultsQuery));
			//ul.addEventListener(Event.COMPLETE, onResultParse);
			ul.addEventListener(Event.COMPLETE, onParse);
		}
		
//		protected function onResultParse(event:Event):void
//		{
//			_vosResult = [];
//			
//			var jsonData:Object = JSON.parse(event.currentTarget.data + "");
//			
//			for each(var resultsNode:Object in jsonData.results)
//			{
//				if(resultsNode.title != undefined &&
//					resultsNode.artists != undefined &&
//					resultsNode.genres != undefined &&
//					resultsNode.key != undefined && 
//					resultsNode.key.shortName != undefined &&
//					resultsNode.price != undefined && 
//					resultsNode.price.display != undefined)
//				{
//					var vo : MusicVO = new MusicVO();
//					vo.id = resultsNode.id;
//					vo.title = resultsNode.title;
//					vo.artist = resultsNode.artists[0].name;
//					vo.genre = resultsNode.genres[0].name;
//					vo.key = resultsNode.key.shortName;
//					vo.price = resultsNode.price.display;
//					
//					_vosResult.push(vo);
//				}else{
//					trace("undefined");
//				}
//			}
//			
//			for each (var object : MusicVO in _vos)
//			{
//				trace("-------------------------------")
//				trace(object.id);
//				trace(object.title);
//				trace(object.artist);
//				trace(object.genre);
//				trace(object.key);
//			}
//			
//			createReparseResults();
//		}
		
//		private function createReparseResults():void
//		{
//			
//			//http://snipplr.com/view/10717/
//			var _scope:DisplayObjectContainer = this; // set the desired scope here, or below if you want to keep it to one line
//			trace(_scope.numChildren);
//			while(_scope.numChildren > 2)
//			{
//				_scope.removeChildAt(_scope.numChildren-1);
//			}
//			trace(_scope.numChildren);
//			
//			
//			for(var i:uint=0;i<_vosResult.length; i++)
//			{
//				
//				_resultTitle = new TextField();
//				addChild(_resultTitle);
//				_resultTitle.defaultTextFormat = resultFormat;
//				_resultTitle.border = false;
//				_resultTitle.x = 10;
//				_resultTitle.y = (i*30)+240;
//				_resultTitle.width = 400;
//				_resultTitle.height = 30;
//				_resultTitle.text = _vosResult[i].title;
//				_resultTitle.addEventListener(MouseEvent.MOUSE_UP, onResultSearch);
//				
//				_resultArtist = new TextField();
//				addChild(_resultArtist);
//				_resultArtist.defaultTextFormat = resultFormat;
//				_resultArtist.border = false;
//				_resultArtist.x = 410;
//				_resultArtist.y = (i*30)+240;
//				_resultArtist.width = 275;
//				_resultArtist.height = 30;
//				_resultArtist.text = _vosResult[i].artist;
//				
//				_resultGenre = new TextField();
//				addChild(_resultGenre);
//				_resultGenre.defaultTextFormat = resultFormat;
//				_resultGenre.border = false;
//				_resultGenre.x = 685;
//				_resultGenre.y = (i*30)+240;
//				_resultGenre.width = 120;
//				_resultGenre.height = 30;
//				_resultGenre.text = _vosResult[i].genre;
//				
//				_resultKey = new TextField();
//				addChild(_resultKey);
//				_resultKey.defaultTextFormat = resultFormat;
//				_resultKey.border = false;
//				_resultKey.x = 805;
//				_resultKey.y = (i*30)+240;
//				_resultKey.width = 100;
//				_resultKey.height = 30;
//				_resultKey.text = _vosResult[i].key;
//				
//				_resultPrice = new TextField();
//				addChild(_resultPrice);
//				_resultPrice.defaultTextFormat = resultFormat;
//				_resultPrice.border = false;
//				_resultPrice.x = 905;
//				_resultPrice.y = (i*30)+240;
//				_resultPrice.width = 60;
//				_resultPrice.height = 30;
//				_resultPrice.text = _vosResult[i].price;
//				
//			}
//		}
		
	}
}