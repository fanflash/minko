package aerys.minko.render.shader.parts.animation
{
	import aerys.minko.render.shader.ActionScriptShader;
	import aerys.minko.render.shader.SFloat;
	import aerys.minko.render.shader.ShaderPart;
	import aerys.minko.type.stream.format.VertexComponent;
	
	public class VertexAnimationShaderPart extends ShaderPart
	{
		private var _morphingShaderPart : MorphingShaderPart;
		private var _skinningShaderPart : SkinningShaderPart;
		
		public function VertexAnimationShaderPart(main : ActionScriptShader)
		{
			super(main);
			
			_skinningShaderPart = new SkinningShaderPart(main);
		}
		
		public function getAnimatedVertexPosition() : SFloat
		{
			var vertexPosition	: SFloat	= vertexXYZ;
			
			if (meshBindings.propertyExists("morphingEnabled"))
				vertexPosition = _morphingShaderPart.getMorphedPosition();
			
			if (meshBindings.propertyExists("skinningMethod"))
				vertexPosition = _skinningShaderPart.skinPosition(vertexPosition);
			
			return vertexPosition;
		}
		
		public function getAnimatedVertexNormal() : SFloat
		{
			if (meshBindings.propertyExists("morphingEnabled"))
				return _morphingShaderPart.getMorphedNormal();
			
			if (meshBindings.propertyExists("skinningMethod"))
				return _skinningShaderPart.skinNormal(vertexNormal);
			
			return vertexNormal;
		}
	}
}