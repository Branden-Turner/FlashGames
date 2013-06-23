package BlackJack 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;	
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Tranden Burner
	 */
	public class PlayerController extends Component 
	{
		private var _moveSpeed:uint;
		private var _health:int;
		private var _damageTimer:Timer = null;
		private var _invinceDuration:Number;
		private var _invincible:Boolean = false;
		
		[Embed(source="heart.png")]
		private static var heartImage:Class;
		 
		private var _heart:Bitmap;
		private var _hearts:Array = null;
		 
		public function PlayerController() 
		{
			super( "player", "Player" );
			_hearts = new Array();
			_moveSpeed = 5;
			_health = 30;
			_invinceDuration = 2.5;
			UpdateHealth();
		}
		
		public function CleanUpHealthBar() : void
		{
			while ( _hearts.length != 0 )
			{
				var obj:Bitmap = _hearts.pop();
				Engine.instance._mainStage.removeChild(obj);
			}
		}
		
		private function UpdateHealth() : void
		{
			CleanUpHealthBar();
			
			for ( var i:int = 0; i < _health; i += 5 )
			{
				_heart = new heartImage() as Bitmap;
				_heart.x = 5 + i * 12.5;
				_heart.y = 5;
				_hearts[i / 5] = _heart
				Engine.instance._mainStage.addChild(_hearts[i/5]);
			}
		}
		
		private function ResetInvincibility( event:TimerEvent ) : void
		{
			_invincible = false;
			_damageTimer.stop();
			(parent as GameObject).GetComponent("playerImage").filters = [];
		}
		
		public function TakeDamage( damage:Number ) : void
		{
			if ( !_invincible )
			{
				(parent as GameObject).GetComponent("playerImage").filters = [new BlurFilter(), new GlowFilter()];
				_health -= damage
				UpdateHealth();
				
				if ( _health <= 0 )
				{
					Game.instance.EndGame();
					return;
				}
				_invincible = true;
				if ( _damageTimer == null )
				{
					_damageTimer = new Timer( _invinceDuration * 1000 );
					_damageTimer.addEventListener( TimerEvent.TIMER, ResetInvincibility );
				}

				_damageTimer.start();
			}
		}
		
		// Updates the player movement
		public override function Update( event:Event ) : void
		{
			var walking:Boolean = false;
			
			if ( Engine.instance.inputManager.isKeyPressed( Keyboard.W ) ) 
			{
				parent.y -= _moveSpeed;
				walking = true;
			}
			if ( Engine.instance.inputManager.isKeyPressed( Keyboard.S ) )
			{
				parent.y += _moveSpeed;
				walking = true;
			}
			if ( Engine.instance.inputManager.isKeyPressed( Keyboard.A ) )
			{
				parent.x -= _moveSpeed;
				walking = true;
			}
			if ( Engine.instance.inputManager.isKeyPressed( Keyboard.D ) )
			{
				parent.x += _moveSpeed;
				walking = true;
			}
			
			if ( Engine.instance.inputManager.isKeyPressed( Keyboard.UP ) )
				((parent as GameObject).GetComponent("chainsawImage") as Chainsaw).rotation += 4;
				
			if ( Engine.instance.inputManager.isKeyPressed( Keyboard.DOWN ) )
				((parent as GameObject).GetComponent("chainsawImage") as Chainsaw).rotation -= 4;
			
			((parent as GameObject).GetComponent("playerImage") as PlayerSprite).walking = walking;
			
			if ( parent.x > 850 )
				parent.x = 850;
			else if ( parent.x < 35 )
				parent.x = 35;
				
			if ( parent.y > 540 )
				parent.y = 540;
			else if ( parent.y < 10 )
				parent.y = 10;
		}	
		
	}

}