/*
 View:   FeedforwardLayer
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.layers 
{
	import com.octadecimal.neuralsense.activators.ActivationSigmoid;
	import com.octadecimal.neuralsense.activators.IActivationFunction;
	import com.octadecimal.neuralsense.collections.NMatrix;
	import com.octadecimal.neuralsense.collections.NVector;
	
	/**
	 * A Feedforward Layer passes synaptical values downstream to the next feedforward neural layer.
	 */
	public class FeedforwardLayer 
	{
		/**
		 * Constructor
		 */
		public function FeedforwardLayer(neuronCount:int, activator:IActivationFunction = null) 
		{
			_id = FeedforwardLayer.total++
			_synapses = new NVector(neuronCount);
			_activator = activator ? activator : new ActivationSigmoid();
		}
		
		
        
		// API
		// =========================================================================================
		
		/**
		 * Computes the downstream output synapses, adjusting the values on the
		 * next downstream feedforward neuron layer.
		 * @param	pattern	 Optional input synaptical pattern.
		 * @return	Synapses for *this* layer.
		 */
		public function computeOutputs(pattern:NVector):NVector
		{
			var i:int;
			
			// Pattern passed, set as initial synapses states
			if (pattern)
				for (i = 0; i < neuronCount; i++)
					_synapses.setAt(i, pattern.getAt(i));
			
			// Create input matrix from synapses
			var synapseMatrix:NMatrix = createInputMatrix(_synapses);
			
			// Loop for each downstream neuron
			for (i = 0; i < _downstream.neuronCount; i++)
			{
				// Get neuron
				var neuron:NMatrix = _matrix.getColMatrix(i);
				
				// Derive synapse
				var synapse:Number = _activator.activate(neuron.dotProduct(synapseMatrix));
				
				// Fire synapse downstream
				_downstream.synapses.setAt(i, synapse);
			}
			
			// Return synapses
			return _synapses;
		}
		
		/**
		 * Prunes a neuron by index.
		 * @param	index	Neuron index.
		 */
		public function prune(index:int):void
		{
			// Delete row on this neuron layer
			if (_matrix)
				_matrix.deleteRow(index);
			
			// Delete column on upstream neuron layer
			if (_upstream) if (_upstream.matrix)
				_upstream.matrix.deleteCol(index);
		}
		
		/**
		 * Resets the layer matrix to random values.
		 */
		public function reset():void
		{
			if (_matrix)
				_matrix.randomize( -1, 1);
		}
		
		/**
		 * Returns a clone of the network structure.
		 * @return	Cloned network.
		 */
		public function clone():FeedforwardLayer
		{
			return new FeedforwardLayer(neuronCount, activator);
		}
		
		
        
		// DATA MANIPULATION
		// =========================================================================================
		
		/**
		 * Creates an input matrix (with an extra cell for a threshold) from the passed vector.
		 * @param	pattern	Input vector.
		 */
		private function createInputMatrix(pattern:NVector):NMatrix
		{
			var result:NMatrix = new NMatrix(1, pattern.count + 1);
			
			// Copy weights
			for (var i:int = 0; i < pattern.count; i++)
				result.setAt(0, i, pattern.getAt(i));
			
			// Set initial threshold value
			result.setAt(0, pattern.count, 1);
			
			return result;
		}
		
		
        
		// SETTERS
		// =========================================================================================
		
		public function set downstream(a:FeedforwardLayer):void		
		{ 
			_downstream = a; 
			
			// Add one to the neuron count, providing a threshold value in row 0
			_matrix = new NMatrix(neuronCount + 1, _downstream.neuronCount);
		}
		
		
        
		// PRIVATE
		// =========================================================================================
		
		/**
		 * Unique feedforward layer id.
		 */
		public function get id():int								{ return _id; }
		private var _id:int;
		
		/**
		 * Synapses.
		 */
		public function get synapses():NVector						{ return _synapses; }
		private var _synapses:NVector;
		
		/**
		 * Matrix.
		 */
		public function set matrix(a:NMatrix):void					{ _matrix = a; }
		public function get matrix():NMatrix						{ return _matrix; }
		private var _matrix:NMatrix;
		
		/**
		 * Neuron count.
		 */
		public function get neuronCount():int						{ return _synapses.count; }
		
		/**
		 * Downstream layer. (next)
		 */
		public function get downstream():FeedforwardLayer			{ return _downstream; }
		private var _downstream:FeedforwardLayer;
		
		/**
		 * Upstream layer. (previous)
		 */
		public function set upstream(a:FeedforwardLayer):void		{ _upstream = a; }
		public function get upstream():FeedforwardLayer				{ return _upstream; }
		private var _upstream:FeedforwardLayer;
		
		/**
		 * Activation function.
		 */
		public function get activator():IActivationFunction			{ return _activator; }
		private var _activator:IActivationFunction;
		
		/**
		 * Layer is a hidden layer.
		 */
		public function get isHidden():Boolean						{ return _downstream && _upstream; } 
		
		/**
		 * Layer is an input layer.
		 */
		public function get isInput():Boolean						{ return !_upstream; } 
		
		/**
		 * Layer is an output layer.
		 */
		public function get isOutput():Boolean						{ return !_downstream; } 
		
		
        
		// STATIC
		// =========================================================================================
		
		public static var total:int = 0;
	}
	
}