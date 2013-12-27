/*
 Interace: IActivationFunction
 Author:   Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.activators
{
	
	/**
	 * ...
	 * @author Dylan Heyes
	 */
	public interface IActivationFunction 
	{
		function activate(value:Number):Number;
		function derive(value:Number):Number;
	}
	
}