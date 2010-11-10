package aerys.minko.type.bounding
{
	import aerys.minko.ns.minko;
	
	import flash.geom.Vector3D;
	
	/**
	 * The BoundingSphere class represents a sphere that contains the maximum extend of an object
	 * (ie. an IMeshFilter object).
	 * @author Jean-Marc Le Roux
	 * @see aerys.minko.mesh.filter.IMeshFilter
	 */
	public final class BoundingSphere3D
	{
		use namespace minko;
		
		//{ region vars
		minko var _center	: Vector3D	= null;
		
		private var _radius	: Number	= 0;
		//} endregion
		
		//{ region getters/setters
		/**
		 * The position of the center of the bounding sphere.
		 */
		public function get centerX()	: Number	{ return _center.x; }
		public function get centerY()	: Number	{ return _center.y; }
		public function get centerZ()	: Number	{ return _center.z; }
		
		/**
		 * The radius of the bounding sphere.
		 */
		public function get radius()	: Number	{return _radius;}
		//} endregion
		
		/**
		 * Creates a new BoundingSphere object with the specified center and radius.
		 * @param	myCenter
		 * @param	myRadius
		 */
		public function BoundingSphere3D(myCenter : Vector3D, myRadius : Number)
		{
			_center = myCenter.clone();
			_radius = myRadius;
		}
		/* ! CONSTRUCTOR */
		
		//{ region methods
		/**
		 * Create a new BoundingSphere object by computing its center and radius from
		 * the bottom-left and top-right vertices of a bounding box.
		 * @param	myMin
		 * @param	myMax
		 * @return
		 */
		public static function fromMinMax(myMin : Vector3D, myMax : Vector3D) : BoundingSphere3D
		{
			var center : Vector3D = new Vector3D((myMax.x + myMin.x) / 2.0,
												 (myMax.y + myMin.y) / 2.0,
												 (myMax.z + myMin.z) / 2.0);
			var radius	: Number	= Math.max(Vector3D.distance(center, myMax),
											   Vector3D.distance(center, myMin));
			
			return new BoundingSphere3D(center, radius);
		}
		//} endregion
		
		//{ region internal
		minko function update(myMin : Vector3D, myMax : Vector3D) : void
		{
			_center.x = (myMax.x + myMin.x) / 2.;
			_center.y = (myMax.y + myMin.y) / 2.;
			_center.z =	(myMax.z + myMin.z) / 2.;
			
			_radius = Math.max(Vector3D.distance(_center, myMax),
							   Vector3D.distance(_center, myMin));
		}
		
		public function getCenter() : Vector3D
		{
			return _center.clone();
		}
		
		public function clone() : BoundingSphere3D
		{
			return new BoundingSphere3D(_center, radius);
		}
		//} endregion
	}
}