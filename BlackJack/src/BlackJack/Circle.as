package BlackJack 
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Tranden Burner
	 */
	public class Circle extends Component 
	{
		private var _circle:Image;
		
		public function Circle( color:uint, xPos:int, yPos:int, radius:int ) 
		{
			super("circle", "pre-defined");
			
			var shape:Shape = new Shape();
			
			shape.graphics.beginFill(color);
			shape.graphics.drawCircle(xPos, yPos, radius);
			shape.graphics.endFill();
			
			var bmpData:BitmapData = new BitmapData(radius * 3, radius * 3, true, 0x0);
			bmpData.draw(shape);
 
			var texture:Texture = Texture.fromBitmapData(bmpData);
			_circle = new Image(texture);
			
			addChild(_circle);
		}
		
		public override function Update( event:Event ) : void
		{
			
		}	
		
	}

}