package aerys.minko.render
{
	import aerys.minko.Minko;
	import aerys.minko.type.log.DebugLevel;
	
	import flash.display3D.Context3D;
	import flash.utils.Dictionary;

	public final class RenderingList
	{
		private var _calls			: Dictionary				= new Dictionary();
		private var _states			: Vector.<RendererState>	= new Vector.<RendererState>();
		private var _numStates		: int						= 0;
		
		public function clear() : void
		{
			_numStates = 0;
			_calls = new Dictionary();
		}
		
		public function pushDrawCall(state 	: RendererState,
									 call	: DrawCall) : void
		{
			var calls : Vector.<DrawCall>	= _calls[state] as Vector.<DrawCall>;
			
			if (!calls)
			{
				calls = new Vector.<DrawCall>();
				_calls[state] = calls;
				_states[_numStates] = state;
				++_numStates;
			}
			
			calls.push(call);
		}
		
		public function render(context : Context3D) : uint
		{
			var numTriangles : uint = 0;
			
			context.enableErrorChecking = (Minko.debugLevel & DebugLevel.RENDERER) != 0;
			
			// sort states
			RendererState.sort(_states, _numStates);
			
			// apply states
			for (var i : int = 0; i < _numStates; ++i)
			{
				var state 		: RendererState		= _states[i];
				var calls 		: Vector.<DrawCall> = _calls[state];
				var numCalls	: int				= calls.length;
				
				state.apply(context);
				
				for (var j : int = 0; j < numCalls; ++j)
					numTriangles += calls[j].apply(context);
			}
			
			return numTriangles;
		}
	}
}