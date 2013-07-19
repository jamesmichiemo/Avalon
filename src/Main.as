package
{
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.Keyboard;
	import flash.xml.XMLNode;
	
	import flashx.textLayout.formats.TextAlign;
	
	[SWF(width="980", height="545", framerate="60", backgroundColor="0xededed")]
	
	public class Main extends Sprite
	{
		
		private var _searchField:TextField;
		private var _query:String;
		private var _searchFormat:TextFormat = new TextFormat();
		private var _vos:Array;
		private var _resultTitle:TextField;
		private var _resultArtist:TextField;
		private var _resultGenre:TextField;
		private var _resultKey:TextField;
		private var _resultPrice:TextField;
		private var _resultFormat:TextFormat = new TextFormat();
		private var _resultsQuery:String;
		private var _vosResult:Array;
		private var _vosDos:Array;
		private var _resultTrait:Number;
		private var _resultOugi:String;
		private var _titleLabel:TextField;
		private var _artistLabel:TextField;
		private var _genreLabel:TextField;
		private var _keyLabel:TextField;
		private var _priceLabel:TextField;
		private var _pages:Number;
		private var _index:int;
		private var _pagequery:Number;

		private var _pageField:TextField;

		
		public function Main()
		{
			customMenu();
			initTextFormat();
			createDisplay();
			createSearchField();
			createButton();
		}
		
		public function customMenu():void
		{
			//REMOVE THE BUILT-IN ITEMS
			var cleanMenu:ContextMenu = new ContextMenu();
			cleanMenu.hideBuiltInItems();
			
			//ADD GRAY COPYRIGHT STRING
			var contextTitle:ContextMenuItem = new ContextMenuItem("© Copyright 2013 James Michiemo");
			contextTitle.enabled = false;
			cleanMenu.customItems.push(contextTitle);
			
			//SET IT UP
			contextMenu = cleanMenu;
		}
		
		
		
		
		
		private function initTextFormat():void
		{
			
			_resultFormat.color = 0x666666;
			_resultFormat.font = "Droid Sans";
			_resultFormat.size = 20;
			
			_searchFormat.color = 0xaaaaaa;
			_searchFormat.font = "Droid Sans";
			_searchFormat.size = 20;
			
			
			
		}
		
		private function createDisplay():void
		{
			var bg:Layout = new Layout();
			this.addChild(bg);
			bg.y = -180;
			
			_titleLabel = new TextField();
			this.addChild(_titleLabel);
			_titleLabel.defaultTextFormat = _resultFormat;
			_titleLabel.border = false;
			_titleLabel.x = 8;
			_titleLabel.y = 212;
			_titleLabel.scaleX = _titleLabel.scaleY = .8;
			_titleLabel.width = 400;
			_titleLabel.height = 30;
			
			_titleLabel.text = "Title";
			
			_artistLabel = new TextField();
			this.addChild(_artistLabel);
			_artistLabel.defaultTextFormat = _resultFormat;
			_artistLabel.border = false;
			_artistLabel.x = 380;
			_artistLabel.y = 212;
			_artistLabel.scaleX = _artistLabel.scaleY = .8;
			_artistLabel.width = 275;
			_artistLabel.height = 30;
			_artistLabel.text = "Artist";
			
			_genreLabel = new TextField();
			this.addChild(_genreLabel);
			_genreLabel.defaultTextFormat = _resultFormat;
			_genreLabel.border = false;
			_genreLabel.x = 655;
			_genreLabel.y = 212;
			_genreLabel.scaleX = _genreLabel.scaleY = .8;
			_genreLabel.width = 120;
			_genreLabel.height = 30;
			_genreLabel.text = "Genre";
			
			_keyLabel = new TextField();
			this.addChild(_keyLabel);
			_keyLabel.defaultTextFormat = _resultFormat;
			_keyLabel.border = false;
			_keyLabel.x = 795;
			_keyLabel.y = 212;
			_keyLabel.scaleX = _keyLabel.scaleY = .8;
			_keyLabel.width = 100;
			_keyLabel.height = 30;
			_keyLabel.text = "Key";
			
			_priceLabel = new TextField();
			this.addChild(_priceLabel);
			_priceLabel.defaultTextFormat = _resultFormat;
			_priceLabel.x = 920;
			_priceLabel.y = 212;
			_priceLabel.scaleX = _priceLabel.scaleY = .8;
			_priceLabel.width = 60;
			_priceLabel.height = 30;	
			_priceLabel.text = "Buy";
		}
		
		private function createButton():void
		{
			
			var button:BoxBase = new BoxBase();
			this.addChild(button);
			button.x = _searchField.x + 540;
			button.y = _searchField.y;
			button.scaleX = button.scaleY = .55;
			button.tfLabel.text = "Search";
			button.tfLabel.x = -18;
			button.tfLabel.y = 1;
			button.tfLabel.scaleX = button.tfLabel.scaleY = 1.8;
			button.mouseChildren = false;
			button.buttonMode = true;
			button.addEventListener(MouseEvent.CLICK, onSearch);
			
		}
		
		protected function onNext(event:MouseEvent):void
		{
			_index++;
			if(_index > _pages)
			{
				_index = _pages;
			}
			
			trace(_index + "-----------------------------------------------------------------------------");
			
			//http://snipplr.com/view/10717/
			var _scope:DisplayObjectContainer = this;
			
			while(_scope.numChildren > 12)
			{
				
				_scope.removeChildAt(_scope.numChildren-1);
				
			}
			
			getSearchList();
		}
		
		
		
		private function formatText():void
		{
			
			_searchFormat.color = 0x222222;
			
		}
		
		private function createSearchField():void
		{
			
			_searchField = new TextField();
			this.addChild(_searchField);
			_searchField.defaultTextFormat = _searchFormat;
			_titleLabel.defaultTextFormat = _searchFormat; // not sure what the problem is here with format
			_searchField.border = false;
			_searchField.x = 13;
			_searchField.y = 9;
			_searchField.width = 530;
			_searchField.height = 27;
			_searchField.type = TextFieldType.INPUT;
			_searchField.text = "Search Artist, Label or Track"; // create public static constant for this string
			// get key presses only when the textfield is being edited
			_searchField.addEventListener(KeyboardEvent.KEY_DOWN, enterSearch);
			// http://stackoverflow.com/questions/3819296/how-to-clear-a-text-field-on-focus-with-as3
			_searchField.addEventListener(FocusEvent.FOCUS_IN, clearBox);
			
		}

		private function clearBox(FocusEvent:Object):void
		{
			if(_searchField.text == "Search Artist, Label or Track")
			{
			_searchField.text=""; //To Clear the Text Box
			}
			formatText();
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
			_index = 1;
			
			//http://snipplr.com/view/10717/
			var _scope:DisplayObjectContainer = this;
			
			while(_scope.numChildren > 8)
			{
				
				_scope.removeChildAt(_scope.numChildren-1);
				
			}
			
			paginate();

			
			_query = _searchField.text;
			
			getSearchList();
			
		}
		
		private function paginate():void
		{
			var nextButton:ArrowBeat = new ArrowBeat();
			this.addChild(nextButton);
			nextButton.x = stage.stageWidth/2 + 460;
			nextButton.y = stage.stageHeight/2 - 73;
			nextButton.scaleX = nextButton.scaleY = .3;
			nextButton.rotation = -90;
			nextButton.mouseChildren = false;
			nextButton.buttonMode = true;
			nextButton.addEventListener(MouseEvent.CLICK, onNext);
			
			var prevButton:ArrowBeat = new ArrowBeat();
			this.addChild(prevButton);
			prevButton.x = nextButton.x - 120;
			prevButton.y = nextButton.y - nextButton.height;
			prevButton.scaleX = prevButton.scaleY = .3;
			prevButton.rotation = 90;
			prevButton.mouseChildren = false;
			prevButton.buttonMode = true;
			prevButton.addEventListener(MouseEvent.CLICK, onPrev);
			
			var pageLabel:TextField = new TextField();
			this.addChild(pageLabel);
			pageLabel.defaultTextFormat = _resultFormat;
			pageLabel.x = prevButton.x + prevButton.width/2;
			pageLabel.y = prevButton.y - prevButton.height/2;
			pageLabel.text = "page: ";
			
			_pageField = new TextField();
			this.addChild(_pageField);
			_pageField.defaultTextFormat = _resultFormat;
			_pageField.border = true;
			_pageField.borderColor = 0x888888;
			_pageField.x = nextButton.x - 50;
			_pageField.y = nextButton.y - nextButton.height - 6;
			_pageField.width = 40;
			_pageField.height = 27;
			_pageField.type = TextFieldType.INPUT;
			_pageField.text = ""; // create public static constant for this string
			// get key presses only when the textfield is being edited
			_pageField.addEventListener(KeyboardEvent.KEY_DOWN, enterPage);
			// http://stackoverflow.com/questions/3819296/how-to-clear-a-text-field-on-focus-with-as3
			_pageField.addEventListener(FocusEvent.FOCUS_IN, clearBox);
		}
		
		protected function enterPage(event:KeyboardEvent):void
		{
			if(event.charCode == 13)
				{
					onPage();
				}
		
		}
		
		protected function onPage():void
		{
			_index = Number(_pageField.text);
			trace(_index + "-----------------------------------------------------------------------------");
			
			//http://snipplr.com/view/10717/
			var _scope:DisplayObjectContainer = this;
			
			while(_scope.numChildren > 12)
			{
				
				_scope.removeChildAt(_scope.numChildren-1);
				
			}
			
			getSearchList();
		}
		
		protected function onPrev(event:MouseEvent):void
		{
			_index--;
			if(_index < 0)
			{
				_index = 0;
			}
			
			trace(_index + "------------------------------------------------------------------------------");
			
			//http://snipplr.com/view/10717/
			var _scope:DisplayObjectContainer = this;
			
			while(_scope.numChildren > 12)
			{
				
				_scope.removeChildAt(_scope.numChildren-1);
				
			}
			
			getSearchList();
		}
		
		private function getSearchList():void
		{
			
			var ul:URLLoader = new URLLoader();
			var uReq:URLRequest = new URLRequest("http://api.beatport.com/catalog/3/search?facets[0]=fieldType:track&perPage=10&page=" + _index + "&query=" + _query);
			trace(uReq.url);
			ul.load(uReq);
			ul.addEventListener(Event.COMPLETE, onParse);
			
		}
		
		protected function onParse(event:Event):void
		{
			
			_vos = [];
			
			var jsonData:Object = JSON.parse(event.currentTarget.data + "");
			
			var metaNode:Object = jsonData.metadata;
			
			_pages = metaNode.totalPages;
			trace(_pages);
			
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
						vo.trait = 13;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "Bmaj")
					{
						
						vo.key = "B Major";
						vo.trait = 13;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "D&#9839;min")
					{
						
						vo.key = "E♭ Minor";
						vo.trait = 14;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "F&#9839;maj")
					{
						
						vo.key = "F♯ Major";
						vo.trait = 14;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "A&#9839;min")
					{
						
						vo.key = "B♭ Minor";
						vo.trait = 15;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "C&#9839;maj")
					{
						
						vo.key = "D♭ Major";
						vo.trait = 15;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "Fmin")
					{
						
						vo.key = "F Minor";
						vo.trait = 16;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "G&#9839;maj")
					{
						
						vo.key = "A♭ Major";
						vo.trait = 16;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "Cmin")
					{
						
						vo.key = "C Minor";
						vo.trait = 17;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "D&#9839;maj")
					{
						
						vo.key = "E♭ Major";
						vo.trait = 17;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "Gmin")
					{
						
						vo.key = "G Minor";
						vo.trait = 18;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "A&#9839;maj")
					{
						
						vo.key = "B♭ Major";
						vo.trait = 18;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "Dmin")
					{
						
						vo.key = "D Minor";
						vo.trait = 19;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "Fmaj")
					{
						
						vo.key = "F Major";
						vo.trait = 19;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "Amin")
					{
						
						vo.key = "A Minor";
						vo.trait = 20;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "Cmaj")
					{
						
						vo.key = "C Major";
						vo.trait = 20;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "Emin")
					{
						
						vo.key = "E Minor";
						vo.trait = 21;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "Gmaj")
					{
						
						vo.key = "G Major";
						vo.trait = 21;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "Bmin")
					{
						
						vo.key = "B Minor";
						vo.trait = 22;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "Dmaj")
					{
						
						vo.key = "D Major";
						vo.trait = 22;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "F&#9839;min")
					{
						
						vo.key = "F♯ Minor";
						vo.trait = 23;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "Amaj")
					{
						
						vo.key = "A Major";
						vo.trait = 23;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "C&#9839;min")
					{
						
						vo.key = "D♭ Minor";
						vo.trait = 24;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "Emaj")
					{
						
						vo.key = "E Major";
						vo.trait = 24;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.genre == "Progressive House")
					{
						vo.genre = "Prog House";
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
				trace(object.trait);
				trace(object.ougi);
				
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
						vo.trait = 13;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "Bmaj")
					{
						
						vo.key = "B Major";
						vo.trait = 13;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "D&#9839;min")
					{
						
						vo.key = "E♭ Minor";
						vo.trait = 14;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "F&#9839;maj")
					{
						
						vo.key = "F♯ Major";
						vo.trait = 14;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "A&#9839;min")
					{
						
						vo.key = "B♭ Minor";
						vo.trait = 15;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "C&#9839;maj")
					{
						
						vo.key = "D♭ Major";
						vo.trait = 15;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "Fmin")
					{
						
						vo.key = "F Minor";
						vo.trait = 16;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "G&#9839;maj")
					{
						
						vo.key = "A♭ Major";
						vo.trait = 16;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "Cmin")
					{
						
						vo.key = "C Minor";
						vo.trait = 17;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "D&#9839;maj")
					{
						
						vo.key = "E♭ Major";
						vo.trait = 17;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "Gmin")
					{
						
						vo.key = "G Minor";
						vo.trait = 18;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "A&#9839;maj")
					{
						
						vo.key = "B♭ Major";
						vo.trait = 18;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "Dmin")
					{
						
						vo.key = "D Minor";
						vo.trait = 19;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "Fmaj")
					{
						
						vo.key = "F Major";
						vo.trait = 19;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "Amin")
					{
						
						vo.key = "A Minor";
						vo.trait = 20;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "Cmaj")
					{
						
						vo.key = "C Major";
						vo.trait = 20;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "Emin")
					{
						
						vo.key = "E Minor";
						vo.trait = 21;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "Gmaj")
					{
						
						vo.key = "G Major";
						vo.trait = 21;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "Bmin")
					{
						
						vo.key = "B Minor";
						vo.trait = 22;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "Dmaj")
					{
						
						vo.key = "D Major";
						vo.trait = 22;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "F&#9839;min")
					{
						
						vo.key = "F♯ Minor";
						vo.trait = 23;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "Amaj")
					{
						
						vo.key = "A Major";
						vo.trait = 23;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.key == "C&#9839;min")
					{
						
						vo.key = "D♭ Minor";
						vo.trait = 24;
						vo.ougi = "ζ=δτ(ωρ)";
						
					}
					
					if(vo.key == "Emaj")
					{
						
						vo.key = "E Major";
						vo.trait = 24;
						vo.ougi = "∠＝∞";
						
					}
					
					if(vo.genre == "Progressive House")
					{
						vo.genre = "Prog House";
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
				trace(object.trait);
				trace(object.ougi);
				
			}
			
			createSearchResults();
			
		}
		
		private function createResults():void
		{
			
			for(var i:uint=0;i<_vos.length; i++)
			{

				var mf:MusicInfo = new MusicInfo(_vos[i],(i*30)+242);
				this.addChild(mf);
				mf.ougi = _vos[i].ougi;// setting a value in the view from the VO
				mf.trait = _vos[i].trait;// setting a value in the view from the VO
				mf.addEventListener(MouseEvent.CLICK, onResultSearch);
				
			}
			
		}
		
		private function createSearchResults():void
		{
		
			var i:uint = 0;
			var mfArray:Array = new Array();
			for each (var song:MusicVO in _vosDos) 
			{
				
				var isHarmonic:Boolean = Affinity.harmonyBlend(_resultTrait, song.trait, _resultOugi, song.ougi);
				
				
				if(isHarmonic)
				{
					var mf:MusicInfo = new MusicInfo(song,(i*30)+242);
					this.addChild(mf);
					mf.ougi = song.ougi;// setting a value in the view from the VO
					mf.trait = song.trait;// setting a value in the view from the VO
					mf.addEventListener(MouseEvent.CLICK, onResultSearch);
					i++;
					mfArray.push(mf);
				}
			}
			
			trace(mfArray.length + "-------------------------------------------------------------");
			if(mfArray.length == 0)
			{
				var noResults:TextField = new TextField();
				addChild(noResults);
				var errorFormat:TextFormat = new TextFormat();
				errorFormat.align = TextFormatAlign.CENTER;
				errorFormat.color = 0x444444;
				errorFormat.font = "Droid Sans";
				noResults.defaultTextFormat = errorFormat;
				noResults.scaleX = noResults.scaleY = 2;
				noResults.y = stage.stageHeight/2;
				noResults.width = 500;
				noResults.text = 'Sorry.\n\nBeatport\'s "Recommended Tracks" listing for this\n particular selection does NOT have a harmonic track available.\n\nAlternative search features will be available in future releases.';
			}
		}
		
		protected function onResultSearch(event:MouseEvent):void
		{	
			
			while(numChildren > 8)
			{
				removeChildAt(numChildren-1);
			}
			
			_resultsQuery = event.currentTarget.id;
			_resultTrait = event.currentTarget.trait;
			_resultOugi = event.currentTarget.ougi;
			
			getResultSearchList();
			
		}
		
		private function getResultSearchList():void
		{
			
			var ul:URLLoader = new URLLoader();
			ul.load(new URLRequest("http://api.beatport.com/catalog/3/tracks/similar?ids=" + _resultsQuery));
			ul.addEventListener(Event.COMPLETE, onResultParse);
			// create an advanced search feature that searches outside of similar track
			
		}
		
	}
	
}