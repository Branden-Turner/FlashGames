package BlackJack 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	
	import BlackJack.BloodSplatter;
	import org.flintparticles.twoD.renderers.*;
	
	/**
	 * ...
	 * @author Tranden Burner
	 */
	public class Chainsaw extends Component 
	{
		private var myLoader:Loader;
		public var gas:uint = 10;
		private var _chainSawOn:Boolean = false;
		private var _chainSawUseDuration:Number;
		private var _chainSawAnim:MovieClip;
		public var _damage:Number = 0.85;
		
		[Embed(source = "chainsaw_buzz.swf")]
		public var csSprite:Class;
		
		public function Chainsaw( name:String, imageName:String ) 
		{
			super(name, imageName);
			
			// Load image
			_chainSawAnim = new csSprite() as MovieClip;
			
			var parentRect:Rectangle = getBounds(componentParent);
			x += 40;
			y += 85;
			addChild(_chainSawAnim);	
		}
		
		
		public override function Update( event:Event ) : void
		{		
			//_chainSawAnim.play();
			if ( rotation > 140 )
				rotation = 140;
			else if ( rotation < 60 )
				rotation = 60;
				
			var bloodSpraying:Boolean = false;
				
			// Enemy collision
			for ( var i:String in Game.enemies )
			{
				if ( this.TestCollision( Game.enemies[i] ) )
				{
					var enemyObj:GameObject = Game.enemies[i] as GameObject;
					((enemyObj).GetComponent("homingEnemy") as EnemyController).TakeDamage(_damage);
					Game.instance._bloodSpray.x = enemyObj.x + 25;
					Game.instance._bloodSpray.y = enemyObj.y + 50;
					this.filters = [new GlowFilter(), new BlurFilter()];
					
					bloodSpraying = true;
				}
				else
				{
					this.filters = [];
				}
			}
			
			if ( bloodSpraying )
			{

				Game.instance._bloodSpray.start();
			}
			else
			{
				Game.instance._bloodSpray.stop();
			}

		}
		
	}

}