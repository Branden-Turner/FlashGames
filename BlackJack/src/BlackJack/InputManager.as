package BlackJack 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;	
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Tranden Burner
	 */
	public class InputManager extends Sprite
	{
		public var mousePosition:Point;
		private var _stage:Stage;
		
		private var _isPressed:Dictionary;
		private var _wasPressed:Dictionary;
		
		public function InputManager(mainStage:Stage) 
		{	
			_stage = mainStage;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			mousePosition = new Point();
		}
		
		private function onAdded(e:Event):void
		{
		  _stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		  _stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		  _stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		  _isPressed = new Dictionary();
		  _wasPressed = new Dictionary();
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			_isPressed[ event.keyCode ] = true;
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			_isPressed[ event.keyCode ] = false;
		}
		
		public function isKeyPressed( code:uint ) : Boolean
		{
			return _isPressed[ code ];
		}
		
		public function Update( event:Event ) : void
		{
		}
		
		private function onMouseMove(event:MouseEvent):void
		{
			mousePosition.x = event.stageX;
			mousePosition.y = event.stageY;
		}
		
	}

}