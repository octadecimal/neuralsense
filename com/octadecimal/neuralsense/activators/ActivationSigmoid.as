/*
 View:   ActivationSigmoid
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.activators
{
	import com.octadecimal.neuralsense.util.Numbers;
	
	/**
	 * ActivationSigmoid View.
	 */
	public class ActivationSigmoid implements IActivationFunction
	{
		
		/**
		 * Constructor
		 */
		public function ActivationSigmoid() 
		{
			
		}
		
		
        
		// API
		// =========================================================================================
		
		public function activate(value:Number):Number
		{
			return 1.0 / (1 + Numbers.exp( -1.0 * value));
		}
		
		public function derive(value:Number):Number
		{
			return value * (1.0 - value);
		}
	}
	
}