package BlackJack 
{
  import org.flintparticles.common.actions.Age;
  import org.flintparticles.common.displayObjects.Line;
  import org.flintparticles.common.initializers.ColorInit;
  import org.flintparticles.common.initializers.Lifetime;
  import org.flintparticles.common.initializers.ImageClass;
  import org.flintparticles.twoD.actions.Move;
  import org.flintparticles.twoD.actions.RotateToDirection;
  import org.flintparticles.twoD.activities.FollowMouse;
  import org.flintparticles.twoD.emitters.Emitter2D;
  import org.flintparticles.twoD.initializers.Velocity;
  import org.flintparticles.twoD.zones.DiscZone;
  
import org.flintparticles.common.counters.*;
import org.flintparticles.common.displayObjects.RadialDot;
import org.flintparticles.common.initializers.*;
import org.flintparticles.twoD.actions.*;
import org.flintparticles.twoD.emitters.Emitter2D;
import org.flintparticles.twoD.initializers.*;
import org.flintparticles.twoD.renderers.*;
import org.flintparticles.twoD.zones.*;

  import flash.display.DisplayObject;
  import flash.geom.Point;

	
  /**
	 * ...
	 * @author ...
	 */
	public class BloodSplatter extends Emitter2D
	{
		
		public function BloodSplatter( posX:Number, posY:Number ) 
		{
		  counter = new Steady( 100 );
      
		  addInitializer( new ImageClass( RadialDot, [15] ) );
	      addInitializer( new ColorInit( 0xFF00FF00, 0xFF00FF00 ) );
		  addInitializer( new Velocity( new DiscZone( new Point( 0, 0 ), 350, 200 ) ) );
		  addInitializer( new Lifetime( 0.2, 0.6 ) );
		  addInitializer( new ScaleImageInit( 2.0, 2 ) );
		  
		  addAction( new Age() );
		  addAction( new Move() );
		  addAction( new RotateToDirection() );
		  x = posX;
		  y = posY;
		}
		
	}

}