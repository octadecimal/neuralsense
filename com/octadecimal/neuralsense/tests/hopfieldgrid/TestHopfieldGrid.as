/*
 View:   TestHopfieldGrid
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.tests.hopfieldgrid 
{
	import com.octadecimal.neuralsense.collections.NVector;
	import com.octadecimal.neuralsense.networks.HopfieldNetwork;
	import com.octadecimal.neuralsense.util.Debug;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * TestHopfieldGrid View.
	 */
	public class TestHopfieldGrid extends Sprite
	{
		
		/**
		 * Constructor
		 */
		public function TestHopfieldGrid() 
		{
			instance = this;
		}
		
		
        
		// API
		// =========================================================================================
		
		public static function create(count:int):void
		{
			Debug.print(instance, "Creating: " + count + "x" + count);
			
			if (instance.grid)
				instance.removeChild(instance.grid);
			
			// Create network
			instance.network = new HopfieldNetwork(count*count);
			
			// Create grid
			instance.grid = new GridView(count);
			instance.grid.x = 20;
			instance.grid.y = 20;
			instance.addChild(instance.grid);
		}
		
		public static function train():void
		{
			// Train
			instance.network.train(new NVector().fromArray(instance.grid.toPackedArray()));
		}
		
		public static function present():void
		{
			// Present
			var synapses:NVector = instance.network.present(new NVector().fromArray(instance.grid.toPackedArray()));
			
			// Update grid
			instance.grid.setValues(synapses);
		}
		
		public static function clearGrid():void
		{
			instance.grid.clear();
		}
		
		public static function clearMemory():void
		{
			// Create network
			instance.network = new HopfieldNetwork(instance.grid.cells.length);
		}
		
		
        
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Hopfield network.
		 */
		public function set network(a:HopfieldNetwork):void	{ _network = a; }
		public function get network():HopfieldNetwork		{ return _network; }
		private var _network:HopfieldNetwork;
		
		/**
		 * Grid view.
		 */
		public function set grid(a:GridView):void			{ _grid = a; }
		public function get grid():GridView					{ return _grid; }
		private var _grid:GridView;
		
		
        
		// PRIVATE
		// =========================================================================================
		
		// Panel
		public var panel:Panel;
		
		// Reference
		public static var instance:TestHopfieldGrid;
	}
	
}