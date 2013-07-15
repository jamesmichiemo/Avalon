package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class MusicInfo extends Sprite
	{
		private var _vo:MusicVO; //
		private var _id:String;
		private var _title:String;
		//private var title:String;
		private var artist:String;
		private var genre:String;
		private var key:String;
		private var price:String;
		private var _resultTitle:TextField;
		private var _resultFormat:TextFormat = new TextFormat();
		private var _resultArtist:TextField;
		private var _resultGenre:TextField;
		private var _resultKey:TextField;
		private var _resultPrice:BoxBase;
		private var _resultPriceLink:BoxBase;
		
		public function MusicInfo(vo:MusicVO,y:int)
		{
			super();
			//
			_vo = vo;
			//
			this.y = y;
			_id = vo.id;
			_title = vo.title;
			formatText();
			musicResults();
			
		}
		
		public function get title():String
		{
			return _title;
		}

		public function get id():String
		{
			return _id;
		}

		private function formatText():void
		{
			_resultFormat.color = 0x555555;
			_resultFormat.font = "Droid Sans";
			_resultFormat.size = 16;
		}
		
		private function musicResults():void
		{

				
			_resultTitle = new TextField();
			addChild(_resultTitle);
			_resultTitle.defaultTextFormat = _resultFormat;
			_resultTitle.border = false;
			_resultTitle.x = 10;
			_resultTitle.width = 400;
			_resultTitle.height = 30;	
			_resultTitle.text = _vo.title; 
			
				
			_resultArtist = new TextField();
			addChild(_resultArtist);
			_resultArtist.defaultTextFormat = _resultFormat;
			_resultArtist.border = false;
			_resultArtist.x = 410;
			_resultArtist.width = 275;
			_resultArtist.height = 30;
			_resultArtist.text = _vo.artist;

				
			_resultGenre = new TextField();
			addChild(_resultGenre);
			_resultGenre.defaultTextFormat = _resultFormat;
			_resultGenre.border = false;
			_resultGenre.x = 685;
			_resultGenre.width = 120;
			_resultGenre.height = 30;
			_resultGenre.text = _vo.genre;

				
			_resultKey = new TextField();
			addChild(_resultKey);
			_resultKey.defaultTextFormat = _resultFormat;
			_resultKey.border = false;
			_resultKey.x = 805;
			_resultKey.width = 100;
			_resultKey.height = 30;
			_resultKey.text = _vo.key;
				
			_resultPrice = new BoxBase();
			addChild(_resultPrice);
			_resultPrice.defaultTextFormat = _resultFormat;
			_resultPrice.border = false;
			_resultPrice.x = 905;
			_resultPrice.width = 60;
			_resultPrice.height = 30;
			_resultPrice.tfLabel.text = _vo.price;
			_resultPrice.tfLabel.scaleX = _resultPrice.tfLabel.scaleY = 1.5;
			_resultPrice.tfLabel.x = -3;
			_resultPrice.tfLabel.y = 1;
			_resultPrice.buttonMode = true;
			_resultPrice.mouseChildren = false;
			
			_resultPriceLink = new BoxBase();
			addChild(_resultPriceLink);
			_resultPriceLink.alpha = 0;
			_resultPriceLink.x = 905;
			_resultPriceLink.width = 60;
			_resultPriceLink.height = 30;	
			_resultPriceLink.tfLabel.text = _vo.title + "/" + _vo.id;
			_resultPriceLink.addEventListener(MouseEvent.MOUSE_UP, onBuy);
			
		}
		
		protected function onBuy(event:MouseEvent):void
		{
			trace(event.currentTarget.text);
			navigateToURL(new URLRequest("http://www.beatport.com/track/"+event.currentTarget.tfLabel.text), "_blank");
		}

	}
	
}