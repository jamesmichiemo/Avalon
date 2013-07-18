package 
{
	/**
	 * Keeps track of data used navigate through display assets.
	 * 
	 * @author Josh Brown
	 * @since 10.17.2011
	 * @langversion 3.0
	 * @playerversion Flash 10.1
	 */
	public class Paginator 
	{
		//========================================================
		// Private Properties
		//========================================================
		
		private var _assets:Array;
		private var _itemsPerPage:int;
		private var _maxPages:int;
		private var _currentPage:int = 1;
		
		private var _startIndex:int;
		private var _endIndex:int;
		
		//========================================================
		// Getters / Setters
		//========================================================
		
		/**
		 * The array of assets to be displayed.
		 */
		public function get assets():Array { return _assets; }
		public function set assets(value:Array):void
		{
			_assets = value;
			_calculateMaxPages();
		}
		
		
		/**
		 * The number of items that will be displayed in a single page.
		 */
		public function get itemsPerPage():int { return _itemsPerPage; }
		public function set itemsPerPage(value:int):void
		{
			_itemsPerPage = value;
			_calculateMaxPages();
		}
		
		/**
		 * The total number of pages based on the total number of assets and the value of <code>itemsPerPage</code>.
		 */
		public function get maxPages():int { return _maxPages; }
		
		/**
		 * The current page to be displayed.
		 */
		public function get currentPage():int { return _currentPage; }
		
		/**
		 * The position in the assets array that denotes the first asset to be displayed for the current page.
		 */
		public function get startIndex():int { return _startIndex; }
		
		/**
		 * The position in the assets array that denotes the last asset to be displayed for the current page.
		 */
		public function get endIndex():int { return _endIndex; }
		
		//========================================================
		// Constructor Function
		//========================================================
		
		/**
		 * Creates a new instance of the Paginator class.
		 * 
		 * @param	assets An array of all the assets that should be displayed.
		 * @param	itemsPerPage The number of assets that will be displayed on every page.
		 * 
		 * @example
		 * <listing version="3.0">
		 * import com.shiftf12.utilities.Paginator;
		 * 
		 * var assets:Array = [];
		 * 
		 * for(var i:int = 0; i < 10; i++)
		 * {
		 * 		assets.push("asset " + i);
		 * }
		 * 
		 * var paginator:Paginator = new Paginator(assets, 3);
		 * 
		 * if(paginator.gotoNextPage())
		 * {
		 * 		_displayAssets();
		 * 		trace(paginator.toString());
		 * }
		 * 
		 * if(paginator.gotoFirstPage())
		 * {
		 * 		_displayAssets();
		 * 		trace(paginator.toString());
		 * }
		 * 
		 * if(paginator.gotoLastPage())
		 * {
		 * 		_displayAssets();
		 * 		trace(paginator.toString());
		 * }
		 * 
		 * if(paginator.gotoPage(3))
		 * {
		 * 		_displayAssets();
		 * 		trace(paginator.toString());
		 * }
		 * 
		 * function _displayAssets():void
		 * {
		 * 		for(var i:int = paginator.startIndex; i &lt;= paginator.endIndex; i++)
		 * 		{
		 * 			this.addChild(assets[i]);
		 * 		}
		 * }
		 * </listing>
		 */
		public function Paginator(assets:Array, itemsPerPage:int) 
		{
			this.assets = assets;
			this.itemsPerPage = itemsPerPage;
			
			_calculateMaxPages();
		}
		
		//========================================================
		// Public Methods
		//========================================================
		
		/**
		 * Calculates the next page that should be displayed.
		 * 
		 * @return True if it successfully calculated the next page, false otherwise.
		 * 
		 * @example <listing version="3.0">
		 * import com.shiftf12.utilities.Paginator;
		 * var assets:Array = [];
		 * 
		 * for(var i:int = 0; i < 10; i++)
		 * {
		 * 		assets.push("asset " + i);
		 * }
		 * 
		 * var paginator:Paginator = new Paginator(assets, 3);
		 * 
		 * if(paginator.gotoNextPage())
		 * {
		 * 		_displayAssets();
		 * }
		 * </listing>
		 */
		public function gotoNextPage():Boolean
		{
			if (currentPage < maxPages)
			{
				_currentPage++;
				_calculatePagination();
				return true;
			}
			
			return false;
		}
		
		/**
		 * Calculates the previous page that should be displayed.
		 * 
		 * @return True if it successfully calculated the previous page, false otherwise.
		 * 
		 * @example
		 * <listing version="3.0">
		 * import com.shiftf12.utilities.Paginator;
		 * var assets:Array = [];
		 * 
		 * for(var i:int = 0; i &lt; 10; i++)
		 * {
		 * 		assets.push("asset " + i);
		 * }
		 * 
		 * var paginator:Paginator = new Paginator(assets, 3);
		 * 
		 * if(paginator.gotoPreviousPage())
		 * {
		 * 		_displayAssets();
		 * }
		 * </listing>
		 */
		public function gotoPreviousPage():Boolean
		{
			if (currentPage > 1)
			{
				_currentPage--;
				_calculatePagination();
				return true;
			}
			
			return false;
		}
		
		/**
		 * Calculates the first page of assets.
		 * 
		 * @example
		 * <listing version="3.0">
		 * import com.shiftf12.utilities.Paginator;
		 * var assets:Array = [];
		 * 
		 * for(var i:int = 0; i &lt; 10; i++)
		 * {
		 * 		assets.push("asset " + i);
		 * }
		 * 
		 * var paginator:Paginator = new Paginator(assets, 3);
		 * paginator.gotoFirstPage();
		 * _displayAssets();
		 * </listing>
		 */
		public function gotoFirstPage():void
		{
			_currentPage = 1;
			_calculatePagination();
		}
		
		/**
		 * Calculates the last page of assets.
		 * 
		 * @example
		 * <listing version="3.0">
		 * import com.shiftf12.utilities.Paginator;
		 * var assets:Array = [];
		 * 
		 * for(var i:int = 0; i &lt; 10; i++)
		 * {
		 * 		assets.push("asset " + i);
		 * }
		 * 
		 * var paginator:Paginator = new Paginator(assets, 3);
		 * 
		 * paginator.gotoLstPage()
		 * _displayAssets();
		 * </listing>
		 */
		public function gotoLastPage():void
		{
			_currentPage = maxPages;
			_calculatePagination();
		}
		
		/**
		 * Calculates which assets should be displayed based on the given page.
		 * 
		 * @param	page The page from which the assets should be calculated.
		 * 
		 * @return True if the calculation was successfull, false otherwise.
		 * 
		 * @example
		 * <listing version="3.0">
		 * import com.shiftf12.utilities.Paginator;
		 * var assets:Array = [];
		 * 
		 * for(var i:int = 0; i < 10; i++)
		 * {
		 * 		assets.push("asset " + i);
		 * }
		 * 
		 * var paginator:Paginator = new Paginator(assets, 5);
		 * 
		 * if(paginator.gotoPage(4))
		 * {
		 * 		_displayAssets();
		 * }
		 * </listing>
		 */
		public function gotoPage(page:int):Boolean
		{
			if (page > 0 && page <= _maxPages && page != currentPage)
			{
				_currentPage = page;
				_calculatePagination();
				return true;
			}
			
			return false;
		}
		
		/**
		 * Clears the instance of the Paginator class and readies it for garbage collection.
		 */
		public function clear():void
		{
			_assets = null;
			
			_itemsPerPage = 0;
			_maxPages = 0;
			_currentPage = 1;
			_startIndex = 0;
			_endIndex = 0;
		}
		
		/**
		 * A string representation of the paginator class.
		 * 
		 * @return A string that contains the current page and the last page, i.e.: &quot;Page: 3 of 6&quot;
		 */
		public function toString():String
		{
			return "Page: " + currentPage.toString() + " of " + maxPages.toString();
		}
		
		//========================================================
		// Private / Protected Methods
		//========================================================
		
		/**
		 * Calculates the maximum number of pages based on the length of the <code>assets</code> array and the <code>itemsPerPage</code> variable.
		 * 
		 * @private
		 */
		protected function _calculateMaxPages():void
		{
			if (assets && assets.length > 0 && itemsPerPage > 0)
			{
				_maxPages = Math.ceil(assets.length / itemsPerPage);
				_calculatePagination();
			}
		}
		
		/**
		 * Calculates the <code>startIndex</code> and <code>endIndex</code> of the assets that should be displayed on the screen.
		 * 
		 * @private
		 */
		protected function _calculatePagination():void
		{
			_startIndex = (currentPage - 1) * itemsPerPage;
			_endIndex = startIndex + (itemsPerPage - 1);
			
			if (endIndex > assets.length - 1) _endIndex = assets.length - 1;
		}
	}
}