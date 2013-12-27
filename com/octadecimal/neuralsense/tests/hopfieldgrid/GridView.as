/*
 View:   GridView
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.tests.hopfieldgrid 
{
	import com.octadecimal.neuralsense.collections.NVector;
	import flash.display.Sprite;
	
	/**
	 * GridView View.
	 */
	public class GridView extends Sprite
	{
		
		/**
		 * Constructor
		 */
		public function GridView(size:int) 
		{
			createCells(size);
		}
		
		
        
		// API
		// =========================================================================================
		
		public function setValues(values:NVector):void
		{
			for (var i:int = 0; i < values.count; i++)
				_cells[i].enabled = values.getAt(i) == 1 ? true : false;
		}
		
		public function clear():void
		{
			for (var i:int = 0; i < _cells.length; i++)
				_cells[i].enabled = false;
		}
		
		public function toPackedArray():Array
		{
			var result:Array = new Array();
			for (var i:int = 0; i < _cells.length; i++)
				result.push(_cells[i].enabled ? 1 : 0);
			return result;
		}
		
		
        
		// VIEW MANIPULATION
		// =========================================================================================
		
		private function createCells(size:int):void
		{
			var cellWidth:Number = 600 / size;
			var cellHeight:Number = 600 / size;
			
			for (var c:int = 0; c < size; c++)
				for (var r:int = 0; r < size; r++)
				{
					var cell:CellView = new CellView(cellWidth, cellHeight);
					cell.x = c * cellWidth;
					cell.y = r * cellHeight;
					addChild(cell);
					_cells.push(cell);
				}
		}
		
		
        
		// EVENTS
		// =========================================================================================
		
		
		
        
		// PRIVATE
		// =========================================================================================
		
		/**
		 * Cell views.
		 */
		public function get cells():Vector.<CellView>		{ return _cells; }
		private var _cells:Vector.<CellView>				= new Vector.<CellView>();
	}
	
}