/*
 View:   Numbers
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.util 
{
	
	/**
	 * Numbers View.
	 */
	public class Numbers 
	{
		public static const FLOOR:Number = -1.0E20;
		public static const CEILING:Number = 1.0E20;
		
		/**
		 * Constructor
		 */
		public function Numbers() 
		{
			
		}
		
		
        
		// API
		// =========================================================================================
		
		public static function clamp(value:Number):Number
		{
			if (value < FLOOR) return FLOOR;
			if (value > CEILING) return CEILING;
			return value;
		}
		
		public static function exp(value:Number):Number
		{
			return clamp(Math.exp(value));
		}
		
		
        
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// EVENTS
		// =========================================================================================
		
		
		
        
		// PRIVATE
		// =========================================================================================
		
		
	}
	
}