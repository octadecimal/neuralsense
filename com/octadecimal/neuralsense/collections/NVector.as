/*
 View:   NVector
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.collections 
{
	import com.octadecimal.neuralsense.util.Debug;
	
	/**
	 * A single-dimensional table of scalar values with various
	 * provided methods for manipulating the data within individually
	 * or collectively as a group, as well as against other vectors.
	 */
	public class NVector
	{
		/**
		 * Constructor.
		 * @param	size	Size of vector.
		 * @param	values	(optional) Pre-defined values, must match value passed in `count`.
		 */
		public function NVector(size:uint = 0/*, values:Array = null*/) 
		{
			// Generate id
			_id = NVector.total++;
			
			// Save count
			_count = size;
			
			// Create empty data table
			_data = new Vector.<Number>(size, true);
			
			// Copy optional passed values
			/*if(values)
				for (var i:uint = 0; i < values.length; i++)
					setAt(i, values[i]);*/
		}
		
		
        
		// INPUT
		// =========================================================================================
		
		/**
		 * Copies the contents of the input vector to the contents of this vector.
		 * @param	input	Input vector.
		 */
		public function copy(input:NVector):NVector
		{
			_count = input.count;
			for (var i:uint = 0; i < Math.min(input.count, _count); i++)
				setAt(i, input.getAt(i));
			return this;
		}
		
		/**
		 * Returns an identical copy of this vector.
		 * @return	Cloned instance.
		 */
		public function clone():NVector
		{
			var result:NVector = new NVector(_count);
			for (var i:uint = 0; i < _count; i++)
				result.setAt(i, getAt(i));
			return result;
		}
		
		public function fromArray(data:Array):NVector
		{
			_count = data.length;
			_data = new Vector.<Number>(_count, true);
			for (var i:int = 0; i < data.length; i++)
				_data[i] = data[i];
			return this;
		}
		
        
		// OUTPUT
		// =========================================================================================
		
		/**
		 * Formatted string representation of this object.
		 * @return	Formatted string.
		 */
		public function toString():String
		{
			var result:String = "[object NVector #"+_id+"] ";
			result += "[" + _count + "]\n";
			result += _data.toString();
			return result;
		}
		
		/**
		 * Returns the vector as a packed array.
		 * @return	Packed array.
		 */
		public function toArray():Array
		{
			var result:Array = new Array();
			for (var i:int = 0; i < _count; i++)
				result.push(getAt(i));
			return result;
		}
		
		
        
		// COMPONENT SETTING/RETREIVING
		// =========================================================================================
		
		/**
		 * Sets a value at a specified index.
		 * @param	index	Index of cell.
		 * @param	value	Value to set.
		 */
		public function setAt(index:uint, value:Number):void
		{
			//Debug.print(this, "Set: " + index + " -> " + value);
			//try {
				_data[index] = value;
			//}
			//catch (e:Error) {
				//Debug.error(this, "Error setting value on NVector #" + _id + ": value=" + value + " @ " + index+"\n"+e);
			//}
		}
		
		/**
		 * Retrieves a value by index.
		 * @param	index	Cell index.
		 * @return	Value at specified cell index.
		 */
		public function getAt(index:uint):Number
		{
			try {
				//Debug.data(this, "Get: " + index + " -> " + _data[index]);
				return _data[index];
			}
			catch (e:Error) {
				Debug.error(this, "Error getting value from NVector #" + _id + " @ " + index + "\n" + e);
			}
			return 0;
		}
		
		
        
		// ARITHMETIC OPERATIONS
		// =========================================================================================
		
		/**
		 * Adds a value to an individual cell's value.
		 * @param	index	Index of cell.
		 * @param	value	Value to add.
		 */
		public function addAt(index:uint, value:Number):void
		{
			try {
				_data[index] += value;
			}
			catch (e:Error) {
				Debug.error(this, "Error adding value on NVector #" + _id + ": value=" + value + " @ " + index+"\n"+e);
			}
			if (isNaN(_data[index]))
				Debug.error(this, "NaN resulted from previous addAt() operation. value="+value);
		}
		
		/**
		 * Subtracts a value from an individual cell's value.
		 * @param	index	Index of cell.
		 * @param	value	Value to subtract.
		 */
		public function subtractAt(index:uint, value:Number):void
		{
			try {
				_data[index] -= value;
			}
			catch (e:Error) {
				Debug.error(this, "Error subtracting value on NVector #" + _id + ": value=" + value + " @ " + index+"\n"+e);
			}
			if (isNaN(_data[index]))
				Debug.error(this, "NaN resulted from previous subtractAt() operation. value="+value);
		}
		
		/**
		 * Multiplies a value on an individual cell's value.
		 * @param	index	Index of cell.
		 * @param	value	Value to multiply.
		 */
		public function multiplyAt(index:uint, value:Number):void
		{
			try {
				_data[index] *= value;
			}
			catch (e:Error) {
				Debug.error(this, "Error multiplying value on NVector #" + _id + ": value=" + value + " @ " + index+"\n"+e);
			}
			if (isNaN(_data[index]))
				Debug.error(this, "NaN resulted from previous multiplyAt() operation. value="+value);
		}
		
		/**
		 * Divides a value from an individual cell's value.
		 * @param	index	Index of cell.
		 * @param	value	Value to divide.
		 */
		public function divideAt(index:uint, value:Number):void
		{
			try {
				_data[index] /= (value != 0) ? value : 1;		// Divide by 1 if 0 passed
			}
			catch (e:Error) {
				Debug.error(this, "Error dividing value on NVector #" + _id + ": value=" + value + " @ " + index+"\n"+e);
			}
			if (isNaN(_data[index]))
				Debug.error(this, "NaN resulted from previous divideAt() operation. value="+value);
		}
		
		/**
		 * Adds a value to all cells within this vector.
		 * @param	value	Value to add.
		 */
		public function add(value:Number):void
		{
			for (var i:uint = 0; i < _count; i++)
				addAt(i, value);
		}
		
		/**
		 * Subtracts a value from all cells within this vector.
		 * @param	value	Value to subtract.
		 */
		public function subtract(value:Number):void
		{
			for (var i:uint = 0; i < _count; i++)
				subtractAt(i, value);
		}
		
		/**
		 * Multiples a value on all cells within this vector.
		 * @param	value	Number to multiply.
		 */
		public function multiply(value:Number):void
		{
			for (var i:uint = 0; i < _count; i++)
				multiplyAt(i, value);
		}
		
		/**
		 * Divides a value on all cells within this vector.
		 * @param	value	Number to divide by.
		 */
		public function divide(value:Number):void
		{
			for (var i:uint = 0; i < _count; i++)
				divideAt(i, value);
		}
		
		/**
		 * Adds a vector to this vector.
		 * @param	input	Vector to add.
		 */
		public function addVector(input:NVector):void
		{
			for (var i:uint = 0; i < Math.min(input.count, _count); i++)
				addAt(i, input.getAt(i));
		}
		
		/**
		 * Subtracts a vector from this vector.
		 * @param	input	Vector to subtract.
		 */
		public function subtractVector(input:NVector):void
		{
			for (var i:uint = 0; i < Math.min(input.count, _count); i++)
				subtractAt(i, input.getAt(i));
		}
		
		/**
		 * Multiplies a vector by this vector.
		 * @param	input	Vector to multiply.
		 */
		public function multiplyVector(input:NVector):void
		{
			for (var i:uint = 0; i < Math.min(input.count, _count); i++)
				multiplyAt(i, input.getAt(i));
		}
		
		/**
		 * Divides a vector by this vector.
		 * @param	input	Vector to divide.
		 */
		public function divideVector(input:NVector):void
		{
			for (var i:uint = 0; i < Math.min(input.count, _count); i++)
				divideAt(i, input.getAt(i));
		}
		
		/**
		 * Tests an input vector for equality against this vector.
		 * @param	input		Input vector to test against.
		 * @param	precision	Test precision.
		 * @return	True if equal, false if inequal.
		 */
		public function equals(input:NVector, precision:Number = 1):Boolean
		{
			precision = Math.pow(10, precision);
			if (input.count != _count)
				return false;
			for (var i:uint = 0; i < _count; i++)
				if (getAt(i) * precision != input.getAt(i) * precision)
					return false;
			return true;
		}
		
		
        
		// STATIC ARITHMETIC OPERATIONS
		// =========================================================================================
		
		/**
		 * Adds two vectors and returns the result as a new vector.
		 * @param	a	Input vector A
		 * @param	b	Input vector B
		 * @return	Resulting vector (new instance).
		 */
		public static function add(a:NVector, b:NVector):NVector
		{
			if (a.count != b.count)
				Debug.warn("[object NVector]", "Adding NVectors with differing lengths.");
			
			var result:NVector = new NVector(Math.max(a.count, b.count));
			result.copy(a);
			
			for (var i:uint = 0; i < a.count; i++)
				result.addAt(i, b.getAt(i));
			
			return result;
		}
		
		/**
		 * Subtracts two vectors and returns the result as a new vector.
		 * @param	a	Input vector A
		 * @param	b	Input vector B
		 * @return	Resulting vector (new instance).
		 */
		public static function subtract(a:NVector, b:NVector):NVector
		{
			if (a.count != b.count)
				Debug.warn("[object NVector]", "Subtracting NVectors with differing lengths.");
			
			var result:NVector = new NVector(Math.max(a.count, b.count));
			result.copy(a);
			
			for (var i:uint = 0; i < a.count; i++)
				result.subtractAt(i, b.getAt(i));
			
			return result;
		}
		
		/**
		 * Multiplies two vectors and returns the result as a new vector.
		 * @param	a	Input vector A
		 * @param	b	Input vector B
		 * @return	Resulting vector (new instance).
		 */
		public static function multiply(a:NVector, b:NVector):NVector
		{
			if (a.count != b.count)
				Debug.warn("[object NVector]", "Multiplying NVectors with differing lengths.");
			
			var result:NVector = new NVector(Math.max(a.count, b.count));
			result.copy(a);
			
			for (var i:uint = 0; i < a.count; i++)
				result.multiplyAt(i, b.getAt(i));
			
			return result;
		}
		
		/**
		 * Divides two vectors and returns the result as a new vector.
		 * @param	a	Input vector A
		 * @param	b	Input vector B
		 * @return	Resulting vector (new instance).
		 */
		public static function divide(a:NVector, b:NVector):NVector
		{
			if (a.count != b.count)
				Debug.warn("[object NVector]", "Dividing NVectors with differing lengths.");
			
			var result:NVector = new NVector(Math.max(a.count, b.count));
			result.copy(a);
			
			for (var i:uint = 0; i < a.count; i++)
				result.divideAt(i, b.getAt(i));
			
			return result;
		}
		
		public static function toBipolar(input:NVector):NVector
		{
			var values:Array = new Array();
			for each(var value:Number in input.data)
				values.push(value > 0 ? 1 : -1);
			return new NVector(input.count).fromArray(values);
		}
		
		public static function toBoolean(input:NVector):NVector
		{
			var values:Array = new Array();
			for each(var value:Number in input.data)
				values.push(value > 0 ? 1 : 0);
			return new NVector(input.count).fromArray(values);
		}
		
		
        
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Cell count.
		 */
		public function get count():uint				{ return _count; }
		private var _count:uint;
		
		/**
		 * Vector data.
		 */
		public function get data():Vector.<Number>		{ return _data; }
		private var _data:Vector.<Number>;
		
		/**
		 * Unique NVector id.
		 */
		public function get id():uint					{ return _id; }
		private var _id:uint;
		
		
        
		// PRIVATE
		// =========================================================================================
		
		// Count of NVectors created. Used to also generate unique IDs.
		private static var total:uint = 0;
	}
}