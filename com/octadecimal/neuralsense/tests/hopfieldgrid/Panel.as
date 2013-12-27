/*
 View:   Panel
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.tests.hopfieldgrid 
{
	import fl.controls.*;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * Panel View.
	 */
	public class Panel extends Sprite
	{
		
		/**
		 * Constructor
		 */
		public function Panel() 
		{
			btnCreate.addEventListener(MouseEvent.MOUSE_UP, onCreateClicked);
			btnTrain.addEventListener(MouseEvent.MOUSE_UP, onTrainClicked);
			btnPresent.addEventListener(MouseEvent.MOUSE_UP, onPresentClicked);
			btnClearGrid.addEventListener(MouseEvent.MOUSE_UP, onClearGridClicked);
			btnClearMemory.addEventListener(MouseEvent.MOUSE_UP, onClearMemoryClicked);
		}
		
		
        
		// API
		// =========================================================================================
		
		
		
        
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// EVENTS
		// =========================================================================================
		
		private function onCreateClicked(e:MouseEvent):void 
		{
			TestHopfieldGrid.create(parseInt(txtCount.text));
		}
		
		private function onTrainClicked(e:MouseEvent):void 
		{
			TestHopfieldGrid.train();
		}
		
		private function onPresentClicked(e:MouseEvent):void 
		{
			TestHopfieldGrid.present();
		}
		
		private function onClearGridClicked(e:MouseEvent):void 
		{
			TestHopfieldGrid.clearGrid();
		}
		
		private function onClearMemoryClicked(e:MouseEvent):void 
		{
			TestHopfieldGrid.clearMemory();
		}
		
		
        
		// PRIVATE
		// =========================================================================================
		
		public var txtCount:TextInput;
		public var btnCreate:Button;
		public var btnTrain:Button;
		public var btnPresent:Button;
		public var btnClearGrid:Button;
		public var btnClearMemory:Button;
	}
	
}