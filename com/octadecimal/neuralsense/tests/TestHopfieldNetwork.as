/*
 View:   TestHopfieldNetwork
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.tests 
{
	import com.octadecimal.neuralsense.collections.NVector;
	import com.octadecimal.neuralsense.networks.HopfieldNetwork;
	import com.octadecimal.neuralsense.util.Debug;
	import flash.display.Sprite;
	import nl.demonsters.debugger.MonsterDebugger;
	
	/**
	 * TestHopfieldNetwork View.
	 */
	public class TestHopfieldNetwork extends Sprite
	{
		
		/**
		 * Constructor
		 */
		public function TestHopfieldNetwork() 
		{
			MonsterDebugger.clearTraces();
			Debug.autoClose(2000);
			
			test01();
		}
		
		
        
		// API
		// =========================================================================================
		
		public function test01():void
		{
			_network = new HopfieldNetwork(4);
			
			// Present patterns
			_network.train(new NVector().fromArray([1, 1, 0, 0]));
			_network.train(new NVector().fromArray([0, 0, 1, 1]));
			//_network.train(new NVector().fromArray([1, 0, 0, 0]));
			
			_network.present(new NVector().fromArray([0, 0, 1, 0]));
		}
		
		
        
		// EVENTS
		// =========================================================================================
		
		
		
        
		// PRIVATE
		// =========================================================================================
		
		/**
		 * Hopfield network.
		 */
		public function get network():HopfieldNetwork		{ return _network; }
		private var _network:HopfieldNetwork;
	}
	
}