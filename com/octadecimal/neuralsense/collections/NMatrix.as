/*
 View:   NMatrix
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.collections 
{
	import com.octadecimal.neuralsense.util.Debug;
	import flash.geom.Matrix;
	
	/**
	 * A two-dimensional table of <code>NVector</code> objects, one per row. A collection
	 * of member and static methods are provided for easily manipulating data across the matrix.
	 * @see com.octadecimal.neuralsense.collections.NVector
	 */
	public class NMatrix 
	{
		/**
		 * Constructor.
		 * @param	rows	Number of initial rows.
		 * @param	cols	Number of initial columns.
		 */
		public function NMatrix(rows:uint = 0, cols:uint = 0)
		{
			// Args
			_rows = rows;
			_cols = cols;
			
			// Generate unique NMatrix id
			_id = NMatrix.total++;
			
			// Create data table
			_data = new Vector.<NVector>(rows, true);
			
			// Populate data with empty rows
			for (var i:uint = 0; i < rows; i++)
				_data[i] = new NVector(cols);
		}
		
		
        
		// INPUT
		// =========================================================================================
		
		/**
		 * Copies an input matrix with unique (not copies) rows and columns.
		 * @param	input	Input matrix to copy from.
		 * @return	Reference to self.
		 */
		public function copy(input:NMatrix):NMatrix
		{
			_rows = input.rows;
			_cols = input.cols;
			_data = new Vector.<NVector>(input.data.length, true);
			for (var i:int = 0; i < input.data.length; i++)
				_data[i] = new NVector(input.data[i].count).copy(input.data[i]);
			return this;
		}
		
		/**
		 * Creates the matrix data from a n-series of arrays, one per row.
		 * @param	...rest		Unlimited amount of arrays, one per row.
		 * @return	Reference to self.
		 */
		public function fromRowArrays(...rest):NMatrix
		{
			_data = new Vector.<NVector>(rest.length);
			for (var i:int = 0; i < rest.length; i++)
				_data[i] = new NVector(rest.length).fromArray(rest[i]);
			_rows = _data.length;
			_cols = _data[0].count;
			return this;
		}
		
		/**
		 * Initializes the matrix from a packed array.
		 * @param	cols	Number of columns.
		 * @param	data	Packed array.
		 * @return	Reference to self.
		 */
		public function fromPackedArray(cols:int, data:Array):NMatrix
		{
			_rows = data.length / cols;
			_cols = cols;
			_data = new Vector.<NVector>(_rows, true);
			for (var i:int = 0; i < data.length; i++ )
				_data[i] = new NVector(cols).fromArray(data.splice(0, cols));
			return this;
		}
		
		
        
		// OUTPUT
		// =========================================================================================
		
		/**
		 * Retrieves a unique, identical clone of this matrix.
		 * @return	Cloned matrix.
		 */
		public function clone():NMatrix
		{
			var result:NMatrix = new NMatrix(_rows, _cols);
			result.copy(this);
			return result;
		}
		
		/**
		 * Returns a string formatted output for this matrix.
		 * @return	Formatted string.
		 */
		public function toString():String
		{
			var result:String = "[object NMatrix #"+_id+"]\n";
			result += "[" + _rows + "x" + _cols + "]\n";
			for each(var row:NVector in _data)
				result += row.data.toString() + "\n";
			return result;
		}
		
		/**
		 * Returns this matrix as a single, packed array.
		 * @return	Packed array.
		 */
		public function toPackedArray():Array
		{
			var result:Array = new Array();
			var index:int = 0;
			for each(var row:NVector in _data)
				result = result.concat(row.toArray());
			return result;
		}
		
		
        
		// VALUE ACCESS
		// =========================================================================================
		
		/**
		 * Sets a value at the specified row and column indices.
		 * @param	row		Row index.
		 * @param	col		Column index.
		 * @param	value	Value to set.
		 */
		public function setAt(row:int, col:int, value:Number):void
		{
			try {
				_data[row].setAt(col, value);
			}
			catch (e:Error) {
				Debug.error(this, "Error setting value on NMatrix #" + _id + ": value=" + value + " @ " + row + "," + col + "\n" + e);
			}
		}
		
		/**
		 * Retrieves a value by row and column indices.
		 * @param	row		Row index.
		 * @param	col		Column index.
		 * @return			Cell value.
		 */
		public function getAt(row:int, col:int):Number
		{
			try {
				return _data[row].getAt(col);
			}
			catch (e:Error) {
				Debug.error(this, "Error getting value on NMatrix #" + _id + " @ " + row + "," + col + "\n" + e);
			}
			return 0;
		}
		
		
		
		// ROW/COLUMN MANIPULATION
		// =========================================================================================
		
		/**
		 * Retrieves a single row by index as a new matrix.
		 * @param	index	Row index.
		 * @return	New matrix.
		 */
		public function getRowMatrix(index:int):NMatrix
		{
			return NMatrix.createRowMatrix(_data[index]);
		}
		
		/**
		 * Retrieves a single column by index as a new matrix.
		 * @param	index	Column index.
		 * @return	New matrix.
		 */
		public function getColMatrix(index:int):NMatrix
		{
			var values:Array = new Array();
			for (var r:int = 0; r < _rows; r++)
				values.push(getAt(r, index));
			return NMatrix.createColumnMatrix(new NVector().fromArray(values));
		}
		
		/**
		 * Retrieves a row as a vector component.
		 * @param	index	Row index.
		 * @return	Existing vector component.
		 */
		public function getRowVector(index:int):NVector
		{
			return _data[index];
		}
		
		/**
		 * Retrieves a column as a vector component.
		 * @param	index	Column index.
		 * @return	Existing vector component.
		 */
		public function getCol(index:int):NVector
		{
			var values:Array = new Array()
			for (var r:int = 0; r < _rows; r++)
				values.push(getAt(r, index));
			return new NVector().fromArray(values);
		}
		
		/**
		 * Deletes a row by index.
		 * @param	index	Row index.
		 */
		public function deleteRow(index:int):void
		{
			_data.splice(index, 1);
		}
		
		/**
		 * Deletes a column by index.
		 * @param	index	Column index.
		 */
		public function deleteCol(index:int):void
		{
			for (var r:int = 0; r < _rows; r++)
				_data[r].data.splice(index, 1);
		}
		
		/**
		 * Clears and initializes the matrix with a value, 0 by default.
		 * @param	value	Value to initialize.
		 */
		public function clear(value:Number = 0):void
		{
			for (var r:int = 0; r < _rows; r++)
				for (var c:int = 0; c < _cols; c++)
					setAt(r, c, value);
		}
		
		/**
		 * Sets each cell value randomly between one of the two passed inputs.
		 * @param	a	Input A.
		 * @param	b	Input B.
		 */
		public function randomize(a:Number = -1, b:Number = 1):void
		{
			for (var r:int = 0; r < _rows; r++)
				for (var c:int = 0; c < _cols; c++)
					setAt(r, c, Math.random() < .5 ? a : b);
		}
		
		
        
		// RESULT OPERATIONS
		// =========================================================================================
		
		/**
		 * Returns the dot product of this matrix and an input matrix.
		 * @param	input	Input matrix.
		 * @return	Dot product.
		 */
		public function dotProduct(input:NMatrix):Number
		{
			var a:Array = toPackedArray();
			var b:Array = input.toPackedArray();
			
			var result:Number = 0;
			for (var i:int = 0; i < a.length; i++)
				result += a[i] * b[i];
			
			return result;
		}
		
		/**
		 * Tests this matrix and an input matrix for equality.
		 * @param	input	Input matrix to test against.
		 * @return	True if equal, false if inequal.
		 */
		public function equals(input:NMatrix):Boolean
		{
			if (input.rows != _rows || input.cols != _cols)
				return false;
			for (var r:int = 0; r < _rows; r++)
				if (!_data[r].equals(input.data[r]))
					return false;
			return true;
		}
		
        
		// MATRIX OPERATIONS
		// =========================================================================================
		
		/**
		 * Adds a value to a single cell.
		 * @param	row		Row index.
		 * @param	col		Column index.
		 * @param	value	Value to apply.
		 */
		public function addAt(row:int, col:int, value:Number):void
		{
			try {
				_data[row].addAt(col, value);
			}
			catch (e:Error) {
				Debug.error(this, "Error adding value on NMatrix #" + _id + ": value=" + value + " @ " + row + "," + col + "\n" + e);
			}
		}
		
		/**
		 * Subtracts a value from a single cell.
		 * @param	row		Row index.
		 * @param	col		Column index.
		 * @param	value	Value to apply.
		 */
		public function subtractAt(row:int, col:int, value:Number):void
		{
			try {
				_data[row].subtractAt(col, value);
			}
			catch (e:Error) {
				Debug.error(this, "Error subtracting value on NMatrix #" + _id + ": value=" + value + " @ " + row + "," + col + "\n" + e);
			}
		}
		
		/**
		 * Multiplies a value on a single cell.
		 * @param	row		Row index.
		 * @param	col		Column index.
		 * @param	value	Value to apply.
		 */
		public function multiplyAt(row:int, col:int, value:Number):void
		{
			try {
				_data[row].multiplyAt(col, value);
			}
			catch (e:Error) {
				Debug.error(this, "Error multiplying value on NMatrix #" + _id + ": value=" + value + " @ " + row + "," + col + "\n" + e);
			}
		}
		
		/**
		 * Divides a value on a single cell.
		 * @param	row		Row index.
		 * @param	col		Column index.
		 * @param	value	Value to apply.
		 */
		public function divideAt(row:int, col:int, value:Number):void
		{
			try {
				_data[row].divideAt(col, value);
			}
			catch (e:Error) {
				Debug.error(this, "Error dividing value on NMatrix #" + _id + ": value=" + value + " @ " + row + "," + col + "\n" + e);
			}
		}
		
		/**
		 * Adds a value to all cells.
		 * @param	value	Value to apply.
		 */
		public function add(value:Number):void
		{
			for (var r:int = 0; r < _rows; r++)
				_data[r].add(value);
		}
		
		/**
		 * Subtracts a value from all cells.
		 * @param	value	Value to apply.
		 */
		public function subtract(value:Number):void
		{
			for (var r:int = 0; r < _rows; r++)
				_data[r].subtract(value);
		}
		
		/**
		 * Multiplies a value on all cells.
		 * @param	value	Value to apply.
		 */
		public function multiply(value:Number):void
		{
			for (var r:int = 0; r < _rows; r++)
				_data[r].multiply(value);
		}
		
		/**
		 * Divides a value from all cells.
		 * @param	value	Value to apply.
		 */
		public function divide(value:Number):void
		{
			for (var r:int = 0; r < _rows; r++)
				_data[r].divide(value);
		}
		
		/**
		 * Adds a matrix to this matrix; does not create a copy.
		 * @param	matrix	Matrix to apply.
		 */
		public function addMatrix(matrix:NMatrix):void
		{
			for (var r:int = 0; r < _rows; r++)
				_data[r].addVector(matrix.getRowVector(r));
		}
		
		/**
		 * Subtracts a matrix from this matrix; does not create a copy.
		 * @param	matrix	Matrix to apply.
		 */
		public function subtractMatrix(matrix:NMatrix):void
		{
			for (var r:int = 0; r < _rows; r++)
				_data[r].subtractVector(matrix.getRowVector(r));
		}
		
		/**
		 * Adds a row vector to all rows.
		 * @param	vector	Vector to apply.
		 */
		public function addVector(vector:NVector):void
		{
			for (var r:int = 0; r < _rows; r++)
				_data[r].addVector(vector);
		}
		
		/**
		 * Subtracts a row vector from all rows.
		 * @param	vector	Vector to apply.
		 */
		public function subtractVector(vector:NVector):void
		{
			for (var r:int = 0; r < _rows; r++)
				_data[r].subtractVector(vector);
		}
		
		/**
		 * Multiplies a row vector on all rows.
		 * @param	vector	Vector to apply.
		 */
		public function multiplyVector(vector:NVector):void
		{
			for (var r:int = 0; r < _rows; r++)
				_data[r].multiplyVector(vector);
		}
		
		/**
		 * Divides a row vector from all rows.
		 * @param	vector	Vector to apply.
		 */
		public function divideVector(vector:NVector):void
		{
			for (var r:int = 0; r < _rows; r++)
				_data[r].divideVector(vector);
		}
		
		
        
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Creates a row matrix from the passed vector.
		 * @param	vector	Input vector.
		 * @return	New NMatrix with single row.
		 */
		public static function createRowMatrix(vector:NVector):NMatrix
		{
			var result:NMatrix = new NMatrix(1, vector.count);
			result.addVector(vector);
			return result;
		}
		
		/**
		 * Creates a column matrix from the passed vector.
		 * @param	vector	Input vector.
		 * @return	New NMatrix with single column.
		 */
		public static function createColumnMatrix(vector:NVector):NMatrix
		{
			var result:NMatrix = new NMatrix(vector.count, 1);
			for (var i:int = 0; i < vector.count; i++)
				result.setAt(i, 0, vector.getAt(i));
			return result;
		}
		
		/**
		 * Returns a transposition of the input matrix as a new matrix.
		 * @param	input	Input NMatrix.
		 * @return	Transposed new matrix.
		 */
		public static function transpose(input:NMatrix):NMatrix
		{
			var result:NMatrix = new NMatrix(input.cols, input.rows);
			for (var r:int = 0; r < input.rows; r++)
				for (var c:int = 0; c < input.cols; c++)
					result.setAt(c, r, input.getAt(r, c));
			return result;
		}
		
		/**
		 * Returns an identity matrix.
		 * @param	size	Size of matrix.
		 * @return	Identity matrix.
		 */
		public static function identity(size:int):NMatrix
		{
			var result:NMatrix = new NMatrix(size, size);
			for (var i:int = 0; i < size; i++)
				result.setAt(i, i, 1);
			return result;
		}
		
		/**
		 * Adds two matrices together and returns the result as a new matrix.
		 * @param	a	Input matrix A
		 * @param	b	Input matrix B
		 * @return	Result matrix.
		 */
		public static function add(a:NMatrix, b:NMatrix):NMatrix
		{
			var result:NMatrix;
			
			if (a.rows != b.rows)
				Debug.warn("NMatrix::subtract", "Matrix size mismatch.");
			
			result = new NMatrix(a.rows, b.cols).copy(a);
			
			for (var r:int = 0; r < a.rows; r++)
				result.data[r].addVector(b.data[r]);
			
			return result;
		}
		
		/**
		 * Subtracts two matrices together and returns the result as a new matrix.
		 * @param	a	Input matrix A
		 * @param	b	Input matrix B
		 * @return	Result matrix.
		 */
		public static function subtract(a:NMatrix, b:NMatrix):NMatrix
		{
			var result:NMatrix;
			
			if (a.rows != b.rows)
				Debug.warn("NMatrix::subtract", "Matrix size mismatch.");
			
			result = new NMatrix(a.rows, b.cols).copy(a);
			
			for (var r:int = 0; r < a.rows; r++)
				result.data[r].subtractVector(b.data[r]);
			
			return result;
		}
		
		/**
		 * Multiplies two matrices together and returns the result as a new matrix.
		 * @param	a	Input matrix A
		 * @param	b	Input matrix B
		 * @return	Result matrix.
		 */
		public static function multiply(a:NMatrix, b:NMatrix):NMatrix
		{
			if (b.rows != a.cols)
				Debug.error("[object NMatrix::multiply]", "Unable to multiply, invalid matrix dimensions.");
			
			var output:NMatrix = new NMatrix(a.rows, b.cols);
			
			var col:NVector = new NVector(a.cols);
			
			// Loop through each B column
			for (var bc:int = 0; bc < b.cols; bc++)
			{
				// Get column value from B
				for (var ac:int = 0; ac < a.cols; ac++)
					col.setAt(ac, b.getAt(ac, bc));
				
				// Loop through each A row
				for (var ar:uint = 0; ar < a.rows; ar++)
				{
					var row:NVector = a.getRowVector(ar);
					var sum:Number = 0;
					
					// Sum products of rowA*colB
					for (ac = 0; ac < a.cols; ac++)
						sum += row.getAt(ac) * col.getAt(ac);
					
					// Set value
					output.setAt(ar, bc, sum);
				}
			}
			
			return output;
		}
		
		
        
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Number of cols.
		 */
		public function get cols():uint						{ return _cols; }
		private var _cols:uint;
		
		/**
		 * Matrix data. [row][col]
		 */
		public function get data():Vector.<NVector>			{ return _data; }
		private var _data:Vector.<NVector>;
		
		/**
		 * Unique NMatrix id.
		 */
		public function get id():uint						{ return _id; }
		private var _id:uint;
		
		/**
		 * Number of rows.
		 */
		public function get rows():uint						{ return _rows; }
		private var _rows:uint;
		
		
        
		// PRIVATE
		// =========================================================================================
		
		// Total number of NMatrix object
		public static var total:uint = 0;
	}
}