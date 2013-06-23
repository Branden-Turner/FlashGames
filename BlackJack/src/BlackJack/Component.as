package BlackJack 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Tranden Burner
	 */
	public class Component extends GameObject
	{
		// Basic information about the component, read only
		private var _name:String;
		private var _source:String;
		public var componentParent:GameObject;
		
		public function Component( name:String, source:String ) 
		{
			super();
			_name = name;
			_source = source;
			componentParent = null;
		}
		
		public override function Update( event:Event ) : void
		{
			
		}
		
		// Name read
		public function get componentName():String 
		{
			return _name;
		}
		
		// Source access
		public function get source():String 
		{
			return _source;
		}
		
	}

}