package
{

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.xml.XMLNode;
	
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
			searchFormat.color = 0x555555;
			searchFormat.font = "Droid Sans";
			searchFormat.size = 20;
			
			resultFormat.color = 0x555555;
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
			// get key presses only when the textfield is being edited
			_searchField.addEventListener(KeyboardEvent.KEY_DOWN, enterSearch);
			
		}
		
		private function enterSearch(event:KeyboardEvent):void
		{
			
				if(event.charCode == 13)
				{
					
				  onSearchEnter();
				  
				}
				
			}
		
		private function onSearchEnter():void
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

					if(vo.key == "G&#9839;min")
					{
						
						vo.key = "A-Flat Minor";
						vo.keycode = "1A";
						vo.tone = 1;
						vo.mode = "A";
						
					}
					
					if(vo.key == "Bmaj")
					{
						
						vo.key = "B Major";
						vo.keycode = "1B";
						vo.tone = 1;
						vo.mode = "B";
						
					}
					
					if(vo.key == "D&#9839;min")
					{
						
						vo.key = "E-Flat Minor";
						vo.keycode = "2A";
						vo.tone = 2;
						vo.mode = "A";
						
					}
					
					if(vo.key == "F&#9839;maj")
					{
						
						vo.key = "F-Sharp Major";
						vo.keycode = "2B";
						vo.tone = 2;
						vo.mode = "B";
						
					}
					
					if(vo.key == "A&#9839;min")
					{
						
						vo.key = "B-Flat Minor";
						vo.keycode = "3A";
						vo.tone = 3;
						vo.mode = "A";
						
					}
					
					if(vo.key == "C&#9839;maj")
					{
						
						vo.key = "D-Flat Major";
						vo.keycode = "3B";
						vo.tone = 3;
						vo.mode = "B";
						
					}
					
					if(vo.key == "Fmin")
					{
						
						vo.key = "F Minor";
						vo.keycode = "4A";
						vo.tone = 4;
						vo.mode = "A";
						
					}
					
					if(vo.key == "G&#9839;maj")
					{
						
						vo.key = "A-Flat Major";
						vo.keycode = "4B";
						vo.tone = 4;
						vo.mode = "B";
						
					}
					
					if(vo.key == "Cmin")
					{
						
						vo.key = "C Minor";
						vo.keycode = "5A";
						vo.tone = 5;
						vo.mode = "A";
						
					}
					
					if(vo.key == "D&#9839;maj")
					{
						
						vo.key = "E-Flat Major";
						vo.keycode = "5B";
						vo.tone = 5;
						vo.mode = "B";
						
					}
					
					if(vo.key == "Gmin")
					{
						
						vo.key = "G Minor";
						vo.keycode = "6A";
						vo.tone = 6;
						vo.mode = "A";
						
					}
					
					if(vo.key == "A&#9839;maj")
					{
						
						vo.key = "B-Flat Major";
						vo.keycode = "6B";
						vo.tone = 6;
						vo.mode = "B";
						
					}
					
					if(vo.key == "Dmin")
					{
						
						vo.key = "D Minor";
						vo.keycode = "7A";
						vo.tone = 7;
						vo.mode = "A";
						
					}
					
					if(vo.key == "Fmaj")
					{
						
						vo.key = "F Major";
						vo.keycode = "7B";
						vo.tone =7;
						vo.mode = "B";
						
					}
					
					if(vo.key == "Amin")
					{
						
						vo.key = "A Minor";
						vo.keycode = "8A";
						vo.tone = 8;
						vo.mode = "A";
						
					}
					
					if(vo.key == "Cmaj")
					{
						
						vo.key = "C Major";
						vo.keycode = "8B";
						vo.tone = 8;
						vo.mode = "B";
						
					}
					
					if(vo.key == "Emin")
					{
						
						vo.key = "E Minor";
						vo.keycode = "9A";
						vo.tone = 9;
						vo.mode = "A";
						
					}
					
					if(vo.key == "Gmaj")
					{
						
						vo.key = "G Major";
						vo.keycode = "9B";
						vo.tone = 9;
						vo.mode = "B";
						
					}
					
					if(vo.key == "Bmin")
					{
						
						vo.key = "B Minor";
						vo.keycode = "10A";
						vo.tone = 10;
						vo.mode = "A";
						
					}
					
					if(vo.key == "Dmaj")
					{
						
						vo.key = "D Major";
						vo.keycode = "10B";
						vo.tone = 10;
						vo.mode = "B";
						
					}
					
					if(vo.key == "F&#9839;min")
					{
						
						vo.key = "F-Sharp Minor";
						vo.keycode = "11A";
						vo.tone = 11;
						vo.mode = "A";
						
					}
					
					if(vo.key == "Amaj")
					{
						
						vo.key = "A Major";
						vo.keycode = "11B";
						vo.tone = 11;
						vo.mode = "B";
						
					}
					
					if(vo.key == "C&#9839;min")
					{
						
						vo.key = "D-Flat Minor";
						vo.keycode = "12A";
						vo.tone = 12;
						vo.mode = "A";
						
					}
					
					if(vo.key == "Emaj")
					{
						
						vo.key = "E Major";
						vo.keycode = "12B";
						vo.tone = 12;
						vo.mode = "B";
						
					}
					
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
		
		protected function onResultParse(event:Event):void
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
					
					if(vo.key == "G&#9839;min")
					{
						
						vo.key = "A-Flat Minor";
						vo.keycode = "1A";
						vo.tone = 1;
						vo.mode = "A";
						
					}
					
					if(vo.key == "Bmaj")
					{
						
						vo.key = "B Major";
						vo.keycode = "1B";
						vo.tone = 1;
						vo.mode = "B";
						
					}
					
					if(vo.key == "D&#9839;min")
					{
						
						vo.key = "E-Flat Minor";
						vo.keycode = "2A";
						vo.tone = 2;
						vo.mode = "A";
						
					}
					
					if(vo.key == "F&#9839;maj")
					{
						
						vo.key = "F-Sharp Major";
						vo.keycode = "2B";
						vo.tone = 2;
						vo.mode = "B";
						
					}
					
					if(vo.key == "A&#9839;min")
					{
						
						vo.key = "B-Flat Minor";
						vo.keycode = "3A";
						vo.tone = 3;
						vo.mode = "A";
						
					}
					
					if(vo.key == "C&#9839;maj")
					{
						
						vo.key = "D-Flat Major";
						vo.keycode = "3B";
						vo.tone = 3;
						vo.mode = "B";
						
					}
					
					if(vo.key == "Fmin")
					{
						
						vo.key = "F Minor";
						vo.keycode = "4A";
						vo.tone = 4;
						vo.mode = "A";
						
					}
					
					if(vo.key == "G&#9839;maj")
					{
						
						vo.key = "A-Flat Major";
						vo.keycode = "4B";
						vo.tone = 4;
						vo.mode = "B";
						
					}
					
					if(vo.key == "Cmin")
					{
						
						vo.key = "C Minor";
						vo.keycode = "5A";
						vo.tone = 5;
						vo.mode = "A";
						
					}
					
					if(vo.key == "D&#9839;maj")
					{
						
						vo.key = "E-Flat Major";
						vo.keycode = "5B";
						vo.tone = 5;
						vo.mode = "B";
				
					}
					
					if(vo.key == "Gmin")
					{
						
						vo.key = "G Minor";
						vo.keycode = "6A";
						vo.tone = 6;
						vo.mode = "A";
						
					}
					
					if(vo.key == "A&#9839;maj")
					{
						
						vo.key = "B-Flat Major";
						vo.keycode = "6B";
						vo.tone = 6;
						vo.mode = "B";
						
					}
					
					if(vo.key == "Dmin")
					{
						
						vo.key = "D Minor";
						vo.keycode = "7A";
						vo.tone = 7;
						vo.mode = "A";
						
					}
					
					if(vo.key == "Fmaj")
					{
						
						vo.key = "F Major";
						vo.keycode = "7B";
						vo.tone =7;
						vo.mode = "B";
						
					}
					
					if(vo.key == "Amin")
					{
						
						vo.key = "A Minor";
						vo.keycode = "8A";
						vo.tone = 8;
						vo.mode = "A";
						
					}
					
					if(vo.key == "Cmaj")
					{
						
						vo.key = "C Major";
						vo.keycode = "8B";
						vo.tone = 8;
						vo.mode = "B";
						
					}
					
					if(vo.key == "Emin")
					{
						
						vo.key = "E Minor";
						vo.keycode = "9A";
						vo.tone = 9;
						vo.mode = "A";
						
					}
					
					if(vo.key == "Gmaj")
					{
						
						vo.key = "G Major";
						vo.keycode = "9B";
						vo.tone = 9;
						vo.mode = "B";
						
					}
					
					if(vo.key == "Bmin")
					{
						
						vo.key = "B Minor";
						vo.keycode = "10A";
						vo.tone = 10;
						vo.mode = "A";
						
					}
					
					if(vo.key == "Dmaj")
					{
						
						vo.key = "D Major";
						vo.keycode = "10B";
						vo.tone = 10;
						vo.mode = "B";
						
					}
					
					if(vo.key == "F&#9839;min")
					{
						
						vo.key = "F-Sharp Minor";
						vo.keycode = "11A";
						vo.tone = 11;
						vo.mode = "A";
						
					}
					
					if(vo.key == "Amaj")
					{
						
						vo.key = "A Major";
						vo.keycode = "11B";
						vo.tone = 11;
						vo.mode = "B";
						
					}
					
					if(vo.key == "C&#9839;min")
					{
						
						vo.key = "D-Flat Minor";
						vo.keycode = "12A";
						vo.tone = 12;
						vo.mode = "A";
						
					}
					
					if(vo.key == "Emaj")
					{
						
						vo.key = "E Major";
						vo.keycode = "12B";
						vo.tone = 12;
						vo.mode = "B";
						
					}
					
					
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
			
//			for(var j:uint=0;j<_vos.length; j++)
//			{	
//				var buy:MusicInfo = new MusicInfo(_vos[i],900,(i*30)+240);
//				this.addChild(buy);
//				buy.alpha
//				buy.addEventListener(MouseEvent.MOUSE_UP, onBuy);
//			}
			
		}

			
		
		protected function onBuy(event:MouseEvent):void
		{
			//navigateToURL(new URLRequest("http://www.beatport.com/track/"+event.currentTarget.title+"/"+event.currentTarget.id), "_blank");
		
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