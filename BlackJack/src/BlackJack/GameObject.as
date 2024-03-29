package BlackJack 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Tranden Burner
	 */
	public class GameObject extends Sprite
	{		
		private static var _currentId:Number = 0;
		private var _components:Array = null;
		private var _id:Number;
		private var _name:String;
		private var _dead:Boolean = false;
		
		public function GameObject() 
		{
			_id = _currentId;
			++_currentId;
			_components = new Array();
		}
		
		public function Update( event:Event ) : void
		{
			// Loop through and update all components
			for ( var i:String in _components )
			{
				_components[i].Update(event);
			}
		}
		
		public function Destroy() : void 
		{
			if ( _dead ) return;
			
			_dead = true;
			Engine.instance.objectManager.DestroyGameObject(this);
		}
		
		public function GetComponent( componentName:String ) : Component
		{
			var comp:Component = null;
			
			// Loop through the component array, if you find the name return that component
			for ( var i:String in _components )
			{
				if ( componentName == _components[i].componentName )
				{
					comp = _components[i];
					break;
				}
			}
			
			// Otherwise return null
			return comp;
		}
		
		public function AddComponent( component:Component ) : void
		{
			component.componentParent = this;
			_components.push( component );
			addChild(component);
		}
		
		public function ID() : Number
		{
			return _id;
		}
		
		// * Borrowed from 
		// * GTween by Grant Skinner. Aug 1, 2005
		// * Visit www.gskinner.com/blog
		// Dave showed me this.
		public function TestCollision(obj:DisplayObjectContainer):Boolean
		{
		  // set up default params:
		  var p_alphaTolerance:int = 255;
		  
		  // get bounds:
		  var bounds1:Rectangle = this.getBounds(root);
		  var bounds2:Rectangle = obj.getBounds(root);
		  
		  // rule out anything that we know can't collide:
		  if (((bounds1.right < bounds2.left) || (bounds2.right < bounds1.left)) || ((bounds1.bottom < bounds2.top) || (bounds2.bottom < bounds1.top)) ) 
		  {
			return false;
		  }
		  
		  // determine test area boundaries:
		  var bounds:Rectangle = new Rectangle();
		  bounds.left = Math.max(bounds1.left,bounds2.left);
		  bounds.right = Math.min(bounds1.right,bounds2.right);
		  bounds.top = Math.max(bounds1.top,bounds2.top);
		  bounds.bottom = Math.min(bounds1.bottom,bounds2.bottom);
		  
		  // set up the image to use:
		  if (bounds.width < 1 || bounds.height < 1)
			return false;
			
		  var img:BitmapData = new BitmapData(bounds.right - bounds.left, bounds.bottom - bounds.top, false);
		  
		  // draw in the first image:
		  var mat:Matrix = this.transform.concatenatedMatrix;
		  mat.tx -= bounds.left;
		  mat.ty -= bounds.top;
		  img.draw(this,mat, new ColorTransform(1,1,1,1,255,-255,-255,p_alphaTolerance));
		  
		  // overlay the second image:
		  mat = obj.transform.concatenatedMatrix;
		  mat.tx -= bounds.left;
		  mat.ty -= bounds.top;
		  img.draw(obj,mat, new ColorTransform(1,1,1,1,255,255,255,p_alphaTolerance),"difference");
		  
		  // find the intersection:
		  var intersection:Rectangle = img.getColorBoundsRect(0xFFFFFFFF,0xFF00FFFF);
		  
		  // if there is no intersection, return null:
		  if (intersection.width == 0) { return false; }
		  
		  // adjust the intersection to account for the bounds:
		  intersection.x += bounds.left;
		  intersection.y += bounds.top;
		  
		  img.dispose();
		  return intersection.width > 0 && intersection.height > 0;
		}
		
	}

}