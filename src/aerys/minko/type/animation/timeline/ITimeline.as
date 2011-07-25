package aerys.minko.type.animation.timeline
{
	import aerys.minko.scene.node.IScene;
	import aerys.minko.type.math.Matrix4x4;

	public interface ITimeline
	{
		function get duration() : uint;
		function get target() : String;
		function updateAt(t : uint, scene : IScene) : void;
	}
}