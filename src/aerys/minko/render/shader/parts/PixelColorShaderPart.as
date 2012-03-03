package aerys.minko.render.shader.parts
{
	import aerys.minko.render.shader.ActionScriptShader;
	import aerys.minko.render.shader.SFloat;
	import aerys.minko.render.shader.ShaderPart;
	
	public class PixelColorShaderPart extends ShaderPart
	{
		public function PixelColorShaderPart(main:ActionScriptShader)
		{
			super(main);
		}
		
		public function getPixelColor() : SFloat
		{
			if (meshBindings.propertyExists("diffuseMap"))
			{
				var diffuseMap	: SFloat	= meshBindings.getTextureParameter("diffuseMap");
				var uv			: SFloat	= interpolate(vertexUV);
				
				return sampleTexture(diffuseMap, uv);
			}
			else if (meshBindings.propertyExists("diffuseColor"))
			{
				return meshBindings.getParameter("diffuseColor", 4);
			}
			
			throw new Error(
				"Local parameter 'diffuseColor' or 'diffuseMap' must be set."
			);
		}
	}
}