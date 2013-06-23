package BlackJack 
{
	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Tranden Burner
	 */
	public class Renderable extends Component 
	{
		[Embed(source = "player.png")]
		private static const PlayerImage:Class;
	
		private var _image:Image;
		
		public function Renderable( name:String, imageName:String ) 
		{
			super(name, imageName);
			
			_image = Image.fromBitmap(new PlayerImage());
			addChild(_image);
		}
		
		public override function Update( event:Event ) : void
		{
			
		}	
	}

}