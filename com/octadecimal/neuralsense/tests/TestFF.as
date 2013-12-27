/*
 View:   TestFF
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.tests 
{
	import com.octadecimal.neuralsense.layers.FeedforwardLayer;
	import com.octadecimal.neuralsense.networks.FeedforwardNetwork;
	import com.octadecimal.neuralsense.util.Debug;
	import flash.display.Sprite;
	import nl.demonsters.debugger.MonsterDebugger;
	
	/**
	 * TestFF View.
	 */
	public class TestFF extends Sprite
	{
		
		/**
		 * Constructor
		 */
		public function TestFF() 
		{
			var network:FeedforwardNetwork = new FeedforwardNetwork();
			
			network.addLayer(new FeedforwardLayer(4));
			network.addLayer(new FeedforwardLayer(4));
			network.addLayer(new FeedforwardLayer(4));
			network.addLayer(new FeedforwardLayer(4));
			network.addLayer(new FeedforwardLayer(4));
			
			Debug.autoClose(1000);
		}
		
		
        
		// API
		// =========================================================================================
		
		
		
        
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// EVENTS
		// =========================================================================================
		
		
		
        
		// PRIVATE
		// =========================================================================================
		
		
	}
	
}