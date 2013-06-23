package BlackJack 
{
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;	
	import flash.ui.Keyboard;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Tranden Burner
	 */
	public class EnemyController extends Component 
	{
		private var _moveSpeed:uint;
		private var _health:Number;
		private var _damage:uint;
		
		private var _damageTimer:Timer = null;
		private var _invinceDuration:Number;
		private var _invincible:Boolean = false;
		
		public function EnemyController( derivedName:String ) 
		{
			super( derivedName, "Enemy" );
			_moveSpeed = 5;
			_health = 20;
			_damage = 5;
			_invinceDuration = 0.1;
			
			// Add one to enemy count
			Game.instance.enemiesOnScreen++;
		}
		
		private function ResetInvincibility( event:TimerEvent ) : void
		{
			_invincible = false;
			_damageTimer.stop();
			parent.filters = [];
		}
		
		public function TakeDamage( damage:Number ) : void
		{
			if ( !_invincible )
			{
				parent.filters = [new BlurFilter(), new GlowFilter()];
				_health -= damage
				
				if ( _health <= 0.0 )
				{
					Die();
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
		
		public function Die( addScore:Boolean = true ) : void
		{
			//add to score
			if( addScore )
				Game.instance.score += 100;
			
			//take one away from enemy count
			Game.instance.enemiesOnScreen--;
			
			//remove from enemies array
			Game.enemies.splice( Game.enemies.indexOf( parent as GameObject ), 1 );
			
			// Destroy game object and remove it from the enemies array
			Engine.instance.objectManager.DestroyGameObject( parent as GameObject );
		}
		
		// Updates the player movement
		public override function Update( event:Event ) : void
		{
			// Detect collision with player
			if ( (parent as GameObject).GetComponent("enemyImage").TestCollision( Game.instance.Player().GetComponent("playerImage") ) )
			{
				(Game.instance.Player().GetComponent( "player" ) as PlayerController).TakeDamage( _damage );
				this.filters = [new GlowFilter()];
			}
			else
				this.filters = [];
				
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