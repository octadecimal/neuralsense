/*
 View:   FeedforwardNetwork
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.octadecimal.neuralsense.networks 
{
	import com.octadecimal.neuralsense.layers.FeedforwardLayer;
	import com.octadecimal.neuralsense.util.Debug;
	
	/**
	 * FeedforwardNetwork View.
	 */
	public class FeedforwardNetwork 
	{
		
		/**
		 * Constructor
		 */
		public function FeedforwardNetwork() 
		{
			
		}
		
		
        
		// API
		// =========================================================================================
		
		/**
		 * Adds a Feedforward Layer to the network.
		 * @param	layer	Layer to add.
		 */
		public function addLayer(layer:FeedforwardLayer):void
		{
			Debug.print(this, "Adding layer: " + layer.id);
			
			// Handle hidden/output layers (ignore input layers)
			if (_outputLayer)
			{
				// Connect new layer's input to previous layer's output
				layer.upstream = _outputLayer;
				
				// Set previous layer's output as new layer's input
				_outputLayer.downstream = layer;
			}
			
			// First layer added, set as input and output
			if (_layers.length == 0)
				_inputLayer = _outputLayer = layer;
			
			// Not first layer added, update output layer to new layer
			else
				_outputLayer = layer;
			
			// Store layer
			_layers.push(layer);
		}
		
		
        
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// EVENTS
		// =========================================================================================
		
		
		
        
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Input layer accessor.
		 */
		public function get inputLayer():FeedforwardLayer				{ return _inputLayer; }
		private var _inputLayer:FeedforwardLayer;
		
		/**
		 * Output layer accessor.
		 */
		public function get outputLayer():FeedforwardLayer				{ return _outputLayer; }
		private var _outputLayer:FeedforwardLayer;
		
		/**
		 * Layers.
		 */
		public function get layers():Vector.<FeedforwardLayer>			{ return _layers; }
		private var _layers:Vector.<FeedforwardLayer>					= new Vector.<FeedforwardLayer>();
		
		/**
		 * Neuron count.
		 */
		public function get neuronCount():int							{ var r:int = 0; for(var l:FeedforwardLayer in _layers) r+=l.neuronCount; return r; }
		
		/**
		 * Number of hidden layers.
		 */
		public function get numHiddenLayers():int						{ return _layers.length - 2; }
		
		/**
		 * Hidden layers.
		 */
		public function get hiddenLayers():Vector.<FeedforwardLayer> 	{ return _layers.concat().splice(1, numHiddenLayers); }
	}
	
}