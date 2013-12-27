/*
 View:   HopfieldNetwork
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.networks 
{
	import com.octadecimal.neuralsense.collections.NMatrix;
	import com.octadecimal.neuralsense.collections.NVector;
	import com.octadecimal.neuralsense.util.Debug;
	
	/**
	 * Hopfield neural network. Has a single layer, where all neurons
	 * act as both the input and output layer. All neurons are connected to
	 * every other neuron, but are not connected to themselves.
	 */
	public class HopfieldNetwork 
	{
		/**
		 * Constructor.
		 * @param	size	Network size.
		 */
		public function HopfieldNetwork(size:int)
		{
			Debug.info(this, "Hopfield Network created. size=" + size);
			
			_weights = new NMatrix(size, size);
		}
		
		
        
		// API
		// =========================================================================================
		
		/**
		 * Trains the neural network with an input pattern.
		 * @param	pattern		Pattern to train.
		 */
		public function train(pattern:NVector):void
		{
			Debug.print(this, "Pattern trained: " + pattern.data);
			
			// Convert pattern to bipolar
			pattern = NVector.toBipolar(pattern);
			
			// Create row matrix from patern
			var result:NMatrix = NMatrix.createRowMatrix(pattern);
			
			// Multiply pattern with its transposition
			result = NMatrix.multiply(NMatrix.transpose(result), result);
			
			// Create identity matrix
			var identity:NMatrix = NMatrix.identity(result.cols);
			
			// Apply identity matrix
			result = NMatrix.subtract(result, identity);
			
			// Add calculated pattern matrix to weight matrix
			_weights = NMatrix.add(_weights, result);
		}
		
		/**
		 * Presents a pattern to the network.
		 * @param	pattern	Input pattern.
		 * @return	Output synapses.
		 */
		public function present(pattern:NVector):NVector
		{
			Debug.data(this, "Presenting pattern: " + pattern);
			
			// Create output synapses
			var synapses:NVector = new NVector(pattern.count);
			
			// Convert pattern to bipolar
			pattern = NVector.toBipolar(pattern);
			
			// Create row matrix from pattern
			var patternMatrix:NMatrix = NMatrix.createRowMatrix(pattern);
			
			// Process pattern
			for (var c:int = 0; c < pattern.count; c++)
			{
				// Get neuron
				var neuron:NMatrix = _weights.getColMatrix(c);
				
				// Get dot product of pattern and neuron
				var dotProduct:Number = patternMatrix.dotProduct(NMatrix.transpose(neuron));
				
				// Fire synapse
				synapses.setAt(c, dotProduct > 0 ? 1 : 0);
			}
			
			// Debug
			Debug.print(this, "Synapses fired: " + synapses.data);
			
			// Return fired synapses
			return synapses;
		}
		
		
        
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Weight matrix.
		 */
		public function get weights():NMatrix		{ return _weights; }
		private var _weights:NMatrix;
	}
	
}