package BlackJack 
{
	import flash.events.Event;
	import flash.geom.Point;	
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Tranden Burner
	 */
	public class HomingEnemy extends EnemyController 
	{
		private var _moveSpeed:uint;
		private var _homeAgain:Boolean = true;
		private var _homeAgainTimer:Timer;
		private var _homingDuration:int;
		private var _homingAngle:Number = 0;
		
		public function HomingEnemy() 
		{
			super( "homingEnemy" );
			_moveSpeed = 1;
			_homingDuration = 1;
			
			_homeAgainTimer = new Timer( _homingDuration * 1000 );
			_homeAgainTimer.addEventListener( TimerEvent.TIMER, ResetHoming );
			_homeAgainTimer.start();
		}
		
		private function ResetHoming( event:TimerEvent ) : void
		{
			_homeAgain = true;
		}
		
		// Updates the player movement
		public override function Update( event:Event ) : void
		{
			if ( _homeAgain )
			{
				_homeAgain = false;
				var parentRect:Rectangle = getBounds(parent);
				var playerObj:GameObject = Game.instance.Player();
				
				// Get angle between this and player
				_homingAngle = ( Math.atan2( playerObj.y - (parent.y + parentRect.height / 2), playerObj.x - (parent.x + parentRect.width / 2) ) ) ;
			}
			
			parent.x += _moveSpeed * Math.cos( _homingAngle );
			parent.y += _moveSpeed * Math.sin( _homingAngle );
			
			super.Update(event);
		}	
		
	}

}