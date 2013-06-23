package BlackJack 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	
	/**
	 * ...
	 * @author Tranden Burner
	 */
	public class PlayerSprite extends Component 
	{
		private var myLoader:Loader;
		private var clip:MovieClip = null;
		public var walking:Boolean = true;
		public var wasPaused:Boolean = false;
		
		[Embed(source = "player.swf")]
		public var playerSprite:Class;
		
		[Embed(source = "alien.swf")]
		public var alienSprite:Class;
		
		
		public function PlayerSprite( name:String, imageName:String ) 
		{
			super(name, imageName);
			
			if( name == "playerImage" )
				clip = new playerSprite() as MovieClip;
			else 
				clip = new alienSprite() as MovieClip;
				
			addChild(clip);
		}

		public function onLoaderReady(e:Event) : void
		{     
			  // the image is now loaded, so let's add it to the display tree!     
			  clip = myLoader.content as MovieClip;
			  
			  trace( clip.numChildren );
			  addChild(clip);
		}
		
		public override function Update( event:Event ) : void
		{
			if ( clip != null )
			{
				if ( walking && wasPaused )
				{
					wasPaused = false;
					clip.play();
				}
				else if ( !wasPaused )
				{
					clip.stop();
					wasPaused = true;
				}
			}
		}	
	}
}