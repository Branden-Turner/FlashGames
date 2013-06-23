package BlackJack 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import flash.display.StageAlign;
    import flash.display.StageScaleMode;
	
	import flash.ui.Keyboard;
	
	
	/**
	 * ...
	 * @author Tranden Burner
	 */
	public class Engine extends Sprite
	{		
		// Reference to this class for core access.
		private static var _instance:Engine;
		
		// This manages the stage for every game object
		public var _mainStage:Stage;
		
		// Object creation/destruction interface.
		public var objectManager:ObjectManager;
		
		// For querying input keys n stuff
		public var inputManager:InputManager;
		
		// Constructor
		public function Engine(initStage:Stage) 
		{
			// Init the stage for the engine
			_mainStage = initStage;
			
			// For setting up rendering and possibly touch later.
            _mainStage.scaleMode = StageScaleMode.NO_SCALE;
            _mainStage.align = StageAlign.TOP_LEFT;
			
			// Give the game logic access to the engine
			_instance = this;	
			
			objectManager = new ObjectManager(_mainStage);
			addChild(objectManager);
			
			inputManager = new InputManager(_mainStage);
			addChild(inputManager);

			addEventListener( Event.ENTER_FRAME, Update );
			
			_mainStage.addChild(this);	
		}
		
		// Update
		private function Update( event:Event ) : void
		{
			// Update all objects
			objectManager.Update(event);
			inputManager.Update(event);
		}
		
		// Public interface for engine
		public static function get instance():Engine 
		{
			return _instance;
		}
	}
}