/*
 View:   Strings
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.util
{
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Various utility methods for manipulating strings.
	 */
	public class Strings 
	{
		
		/**
		 * Extracts the name from typical object toString output.
		 */
		public static function fromObject(object:Object):String
		{
			var output:String = object.toString();
			
			if(output != null) output = output.split("[object ")[1];
			if(output != null) output = output.slice(0, output.length - 1);
			
			return (output) ? output : object.toString();
		}
		
		/**
		 * Extracts the name from typical object toString output.
		 */
		public static function fromClass(input:Class):String
		{
			var output:String = getQualifiedClassName(input);
			
			return output.split("::")[1];
		}
		
		
		/**
		 * Appends whitespace to the end of the string until it is the passed length.
		 */
		public static function prependWhitespace(input:String, length:int = 20):String
		{
			for (var output:String="", i:uint = 0; i < length - input.length; i++)
				output += " ";
			
			return output + input;
		}
		
		
		/**
		 * Appends whitespace to the end of the string until it is the passed length.
		 */
		public static function appendWhitespace(input:String, length:int = 20):String
		{
			if (input == null) return prependWhitespace("", length);
			
			for (var output:String=input, i:uint = 0; i < length - input.length; i++)
				output += " ";
			
			return output;
		}
		
		
		/**
		 * Adds columns of widths passed by columnWidths to the input strings array.
		 */
		public static function tabulate(strings:Array, columnWidths:Array):String
		{
			var index:uint = 0;
			var output:String = "";
			
			for each(var string:String in strings)
				output += appendWhitespace(string, columnWidths[index++]);
			
			return output;
		}
		
		
		/**
		 * 
		 */
		public static function objectMessage(object:Object, text:String, length:int=38, seperator:String="    "):String
		{
			// Prepend whitespace
			var output:String = fromObject(object);
			
			// Remove object tag
			output = prependWhitespace(output, length);
			
			// Return
			return output + seperator + text;
		}
	}
	
}