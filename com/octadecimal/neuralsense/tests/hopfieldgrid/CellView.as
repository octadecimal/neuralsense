/*
 View:   CellView
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.tests.hopfieldgrid 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * CellView View.
	 */
	public class CellView extends Sprite
	{
		
		/**
		 * Constructor
		 */
		public function CellView(cellWidth:Number, cellHeight:Number) 
		{
			_cellWidth = cellWidth;
			_cellHeight = cellHeight;
			draw();
			
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		
        
		// API
		// =========================================================================================
		
		public function toggle():void
		{
			enabled = enabled ? false : true;
		}
		
		
        
		// VIEW MANIPULATION
		// =========================================================================================
		
		private function draw():void
		{
			var g:Graphics = this.graphics;
			g.clear();
			
			g.lineStyle(1, 0);
			g.beginFill(_enabled ? 0x0 : 0xFFFFFF);
			g.drawRect(0, 0, _cellWidth, _cellHeight);
		}
		
		
        
		// EVENTS
		// =========================================================================================
		
		private function onOver(e:MouseEvent):void 
		{
			if (_mouseDown && _drawState == _enabled)
				toggle();
		}
		
		private function onDown(e:MouseEvent):void 
		{
			_mouseDown = true;
			_drawState = _enabled;
		}
		
		private function onUp(e:MouseEvent):void 
		{
			_mouseDown = false;
			_drawState = _enabled;
			
			_enabled = _drawState;
		}
		
		
        
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Cell width.
		 */
		public function get cellWidth():Number			{ return _cellWidth; }
		private var _cellWidth:Number;
		
		/**
		 * Cell height.
		 */
		public function get cellHeight():Number			{ return _cellHeight; }
		private var _cellHeight:Number;
		
		/**
		 * Enabled state.
		 */
		public function set enabled(a:Boolean):void		{ _enabled = a; draw(); }
		public function get enabled():Boolean			{ return _enabled; }
		private var _enabled:Boolean					= false;
		
		
        
		// PRIVATE
		// =========================================================================================
		
		private static var _mouseDown:Boolean = false;
		
		private static var _drawState:Boolean = true;
	}
	
}