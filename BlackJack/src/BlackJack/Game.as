package BlackJack
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import BlackJack.BloodSplatter;
	import flash.geom.Point;
	import org.flintparticles.twoD.renderers.*;
	
	public class Game extends Sprite
	{
		public static var enemies:Array;
		private var player:GameObject;
		
		private var spawnTimer:Timer;
		private var timeBetweenSpawns:int;
		private var maxEnemiesOnScreen:int;
		public var enemiesOnScreen:int;
		public var score:int = 0;
		
		private var _scoreText:TextField;
		public var _bloodSpray:BloodSplatter;
		
		// Reference to this for core game logic access
		private static var _instance:Game;
		
		[Embed(source="background.png")]
		private static var bgImage:Class;
		 
		private var _bg:Bitmap = new bgImage() as Bitmap;
		
		[Embed(source="button.png")]
		private static var buttonImage:Class;
		 
		private var bBMap:Bitmap = new buttonImage() as Bitmap;
		private var restartButton:Sprite;
		
		private function randRange( minNum:Number, maxNum:Number ) : Number 
		{
			return ( Math.floor( Math.random() * ( maxNum - minNum + 1 ) ) + minNum );
		}
		
		private function CreatePlayer() : void
		{
			player = Engine.instance.objectManager.CreateGameObject();
			player.AddComponent( new Chainsaw("chainsawImage", "./chainsaw_buzz.swf") );
			player.AddComponent( new PlayerSprite("playerImage", "./player.swf") );
			player.AddComponent( new PlayerController() );
			player.x = 300;
			player.y = 200;
		}
		
		private function SpawnEnemy( xPos:Number, yPos:Number ) : void
		{
			var obj:GameObject = Engine.instance.objectManager.CreateGameObject();
			obj.AddComponent( new PlayerSprite("enemyImage", "./alien.swf") );
			obj.AddComponent( new HomingEnemy() );
			obj.x = xPos;
			obj.y = yPos;
			enemies.push(obj);
		}
		
		public function Player() : GameObject
		{
			return player;
		}
		
		public function EnemySpawner( event:TimerEvent ) : void
		{
			if ( enemiesOnScreen < maxEnemiesOnScreen )
			{
				var x:Number = randRange(0, Engine.instance._mainStage.stageWidth);
				var y:Number = randRange(0, Engine.instance._mainStage.stageHeight);
				SpawnEnemy(x, y);
			}
		}
		
		public function StartGame( event:MouseEvent ) : void
		{
			maxEnemiesOnScreen = 6;
			enemiesOnScreen = 0;
			timeBetweenSpawns = 5;
			score = 0;
			
			enemies = new Array();
			CreatePlayer();
			
			spawnTimer = new Timer( timeBetweenSpawns * 1000 );
			spawnTimer.addEventListener( TimerEvent.TIMER, EnemySpawner );
			spawnTimer.start();
			

			_scoreText.x = 420;
			_scoreText.y = 640;
			_scoreText.scaleX = 3; 
			_scoreText.scaleY = 3;

			
			Engine.instance._mainStage.addChild(_scoreText);
			Engine.instance._mainStage.removeChild(restartButton);
		}
		
		public function EndGame() : void
		{
			_bloodSpray.stop();
			// Kill all enemies
			while ( enemies.length != 0 )
			{
				((enemies[0] as GameObject).GetComponent("homingEnemy") as EnemyController).Die(false);
			}
			
			(player.GetComponent("player") as PlayerController).CleanUpHealthBar();
			
			// Kill the player
			Engine.instance.objectManager.DestroyGameObject( player );
			
			// stop the spawn timer
			spawnTimer.reset();
			
			// Create the menu.  Display score.
			_scoreText.x = 420;
			_scoreText.y = 150;
			_scoreText.scaleX = 4; 
			_scoreText.scaleY = 4;
			

			// then we add the button to stage
			Engine.instance._mainStage.addChild(restartButton);
		}
		
		public function Update( event:Event ) : void
		{
			_scoreText.text = "Score: " + Game.instance.score;
		}
		
		
		public function Game()
		{
			_bg.filters = [new GlowFilter(), new BlurFilter()];
			
			// Load background of the game
			Engine.instance._mainStage.addChild( _bg );
			
			// Create score text
			_scoreText = new TextField();  
			_scoreText.textColor = 0X000000;
			_scoreText.width = 600;
			
			restartButton = new Sprite();
			restartButton.addChild( bBMap );
			restartButton.scaleX = 1.5;
			restartButton.scaleY = 1.5;
			
			//first we create the Sprite which will be our button			
			restartButton.x = 430;
			restartButton.y = 300;
			restartButton.buttonMode  = true;
			restartButton.mouseChildren = false;
			restartButton.addEventListener(MouseEvent.CLICK, StartGame, false, 0, true);
			
			Engine.instance._mainStage.addChild(restartButton);
			
			_bloodSpray = new BloodSplatter( 150, 150 );

			var renderer:DisplayObjectRenderer = new DisplayObjectRenderer();
			renderer.addEmitter( _bloodSpray );
			Engine.instance._mainStage.addChild( renderer );

			_bloodSpray.start();
			_bloodSpray.stop();
			
			StartGame(null);
			_instance = this;
			addEventListener( Event.ENTER_FRAME, Update );
			EndGame();
		}
		
		// Public interface for Game
		public static function get instance():Game 
		{
			return _instance;
		}
	}	
}
