package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class LayoutBox extends Sprite	
	{
		private var _children:Array;
		private var _padding:Number;
		private var _isHorizontal:Boolean;
		
		public function LayoutBox(padding:Number = 5, isHorizontal:Boolean = false)
		{
			super();
			
			_padding = padding;
			_isHorizontal = isHorizontal;
			
			_children = [];
			
		}
		
		public function get isHorizontal():Boolean
		{
			return _isHorizontal;
		}
		
		public function set isHorizontal(value:Boolean):void
		{
			_isHorizontal = value;
			updatePositioning();
		}
		
		public function get padding():Number
		{
			return _padding;
		}
		
		public function set padding(value:Number):void
		{
			_padding = value;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			_children.push(child);
			updatePositioning();
			
			return super.addChild(child);
		}
		
		private function updatePositioning():void
		{
			var pos:Number = 0;
			
			for each(var child:DisplayObject in _children)
			if(_isHorizontal)
			{
				//if _isHorizontal is true
				child.x = pos;
				child.y = 0;
				pos += child.width + _padding;
			}else{
				// if _isHorizontal is false
				child.x = 0;
				child.y = pos;
				
				pos += child.height + _padding;
			}
		}		
		
		
	}
}