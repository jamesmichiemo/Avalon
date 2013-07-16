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
		private var _vos:Array;
		private var _resultTitle:TextField;
		private var _resultArtist:TextField;
		private var _resultGenre:TextField;
		private var _resultKey:TextField;
		private var _resultPrice:TextField;
		private var resultFormat:TextFormat = new TextFormat();
		private var _resultsQuery:String;
		private var _vosResult:Array;
		private var _vosDos:Array;
		private var _resultTone:Number;
		private var _resultMode:String;
		
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
			
			button.addEventListener(MouseEvent.CLICK, onSearch);
			
		}
		
		private function formatText():void
		{
			
			searchFormat.color = 0x555555;
			searchFormat.font = "Droid Sans";
			searchFormat.size = 20;
			
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
				onSearch(null);
			}
			
		}
		
		protected function onSearch(event:MouseEvent):void
		{	
			
			//http://snipplr.com/view/10717/
			var _scope:DisplayObjectContainer = this;
			
			while(_scope.numChildren > 2)
			{
				
				_scope.removeChildAt(_scope.numChildren-1);
				
			}
			
			_query = _searchField.text;
			getSearchList();
			
		}
		
		private function getSearchList():void
		{
			
			var ul:URLLoader = new URLLoader();
			var uReq:URLRequest = new URLRequest("http://api.beatport.com/catalog/3/search?facets[0]=fieldType:track&query=" + _query);
			trace(uReq.url);
			ul.load(uReq);
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
						
						vo.key = "A♭ Minor";
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
						
						vo.key = "E♭ Minor";
						vo.keycode = "2A";
						vo.tone = 2;
						vo.mode = "A";
						
					}
					
					if(vo.key == "F&#9839;maj")
					{
						
						vo.key = "F♯ Major";
						vo.keycode = "2B";
						vo.tone = 2;
						vo.mode = "B";
						
					}
					
					if(vo.key == "A&#9839;min")
					{
						
						vo.key = "B♭ Minor";
						vo.keycode = "3A";
						vo.tone = 3;
						vo.mode = "A";
						
					}
					
					if(vo.key == "C&#9839;maj")
					{
						
						vo.key = "D♭ Major";
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
						
						vo.key = "A♭ Major";
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
						
						vo.key = "E♭ Major";
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
						
						vo.key = "B♭ Major";
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
						
						vo.key = "F♯ Minor";
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
						
						vo.key = "D♭ Minor";
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
				trace(object.tone);
				trace(object.mode);
				
			}
			
			createResults();
			
		}
		
		protected function onResultParse(event:Event):void
		{
			
			_vosDos = [];
			
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
						
						vo.key = "A♭ Minor";
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
						
						vo.key = "E♭ Minor";
						vo.keycode = "2A";
						vo.tone = 2;
						vo.mode = "A";
						
					}
					
					if(vo.key == "F&#9839;maj")
					{
						
						vo.key = "F♯ Major";
						vo.keycode = "2B";
						vo.tone = 2;
						vo.mode = "B";
						
					}
					
					if(vo.key == "A&#9839;min")
					{
						
						vo.key = "B♭ Minor";
						vo.keycode = "3A";
						vo.tone = 3;
						vo.mode = "A";
						
					}
					
					if(vo.key == "C&#9839;maj")
					{
						
						vo.key = "D♭ Major";
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
						
						vo.key = "A♭ Major";
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
						
						vo.key = "E♭ Major";
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
						
						vo.key = "B♭ Major";
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
						
						vo.key = "F♯ Minor";
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
						
						vo.key = "D♭ Minor";
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
					
					_vosDos.push(vo);
					
					
				}else{
					
					trace("undefined");
					
				}
				
				
				
			}
			
			for each (var object : MusicVO in _vosDos)
			{
				
				trace("-------------------------------")
				trace(object.id);
				trace(object.title);
				trace(object.artist);
				trace(object.genre);
				trace(object.key);
				trace(object.tone);
				trace(object.mode);
				
			}
			
			createSearchResults();
			
		}
		
		private function createResults():void
		{
			
			for(var i:uint=0;i<_vos.length; i++)
			{

				var mf:MusicInfo = new MusicInfo(_vos[i],(i*30)+240);
				this.addChild(mf);
				mf.mode = _vos[i].mode;// setting a value in the view from the VO
				mf.tone = _vos[i].tone;// setting a value in the view from the VO
				mf.addEventListener(MouseEvent.CLICK, onResultSearch);
				
			}
			
		}
		
		private function createSearchResults():void
		{
		
			var i:uint = 0;
			for each (var song:MusicVO in _vosDos) 
			{
				
				var isHarmonic:Boolean = Camelot.harmonyBlend(_resultTone, song.tone, _resultMode, song.mode);
				
				if(isHarmonic)
				{
					var mf:MusicInfo = new MusicInfo(song,(i*30)+240);
					this.addChild(mf);
					mf.mode = song.mode;// setting a value in the view from the VO
					mf.tone = song.tone;// setting a value in the view from the VO
					mf.addEventListener(MouseEvent.CLICK, onResultSearch);
					i++;
				}
				
				
			}
			
		}
		
		protected function onResultSearch(event:MouseEvent):void
		{	
			
			while(numChildren > 2)
			{
				removeChildAt(numChildren-1);
			}
			
			_resultsQuery = event.currentTarget.id;
			_resultTone = event.currentTarget.tone;
			_resultMode = event.currentTarget.mode;
			
			getResultSearchList();
			
		}
		
		private function getResultSearchList():void
		{
			
			var ul:URLLoader = new URLLoader();
			ul.load(new URLRequest("http://api.beatport.com/catalog/3/tracks/similar?ids=" + _resultsQuery));
			ul.addEventListener(Event.COMPLETE, onResultParse);
			
		}
		
	}
	
}