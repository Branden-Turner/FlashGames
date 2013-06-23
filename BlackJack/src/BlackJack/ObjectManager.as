package BlackJack 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Tranden Burner
	 */
	public class ObjectManager extends Sprite
	{
		private var _objects:Dictionary = null;
		private var _stage:Stage;
		private var _deadObjects:Array = null;
		
		public function ObjectManager( gameStage:Stage ) 
		{
			_objects = new Dictionary();
			_deadObjects = new Array();
			_stage = gameStage;
		}
		
		public function Update( event:Event ) : void
		{
			// Update all game objects
			for ( var i:String in _objects )
			{
				_objects[i].Update( event );
			}
			
			CleanUpDeadObjects();
		}
		
		public function CreateGameObject():GameObject
		{
			var obj:GameObject = new GameObject();
			
			_objects[ obj.ID() ] = obj;
			
			_stage.addChild(obj);
			
			return obj;
		}
		
		public function DestroyGameObject( object:GameObject ) : void
		{
			_deadObjects.push(object);
		}
		
		private function CleanUpDeadObjects() : void
		{
		  // Call destructor for each game object in the dead objects array.
		  for (var id:String in _deadObjects)
		  {
			var object:GameObject = _deadObjects[id];
			if( _stage.contains(object) )
				_stage.removeChild(object);
			delete _objects[object.ID()];			
		  }
		  
		  // Clear the array of references
		  _deadObjects = [];
		}
		
	}

}